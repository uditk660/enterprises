class EmployeeMonthlySalariesController < ApplicationController
  before_action :set_company
  before_action :set_employee
  before_action :set_salary_structure
  before_action :set_monthly_salary, only: [:show, :edit, :update, :confirm_payment]

  def index
    @monthly_salaries = @employee.employee_monthly_salaries.order(month: :desc)
  end

  def new
    @monthly_salary =
      @employee.employee_monthly_salaries.new( employee_salary_structure: @salary_structure, month: Date.current.beginning_of_month)
  end

  def create
    @monthly_salary = @employee.employee_monthly_salaries.new
    @monthly_salary.employee_salary_structure = @salary_structure
    @monthly_salary.assign_attributes(monthly_salary_params)

    if @monthly_salary.save
      redirect_to company_employee_employee_monthly_salaries_path(@company, @employee),
        notice: "Salary generated successfully"
    else
      render :new
    end
  end

  def show
  end

  # Making a pending payment as PAID
  # POST /employee_monthly_salaries/:id/confirm_payment
  def confirm_payment
    return redirect_back fallback_location: root_path if @monthly_salary.paid?

    ActiveRecord::Base.transaction do
      LedgerEntry.create!(
        entry_date: Date.today,
        entry_type: :debit,
        debit: @monthly_salary.net_salary,
        credit: 0,
        ledgerable_type: "salary",
        description: "Salary paid for #{@monthly_salary.month.strftime('%B %Y')}",
        employee: @monthly_salary.employee,
        employee_monthly_salary: @monthly_salary
      )

      @monthly_salary.update!(payment_status: "paid", paid_on: Date.today)
    end

    redirect_to company_employee_employee_monthly_salary_path(@company, @employee, @monthly_salary), notice: "Salary marked as PAID"
  end

  ################ Private method goes here ################
  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_employee
    @employee = @company.employees.find(params[:employee_id])
  end

  def set_salary_structure
    @salary_structure = @employee.employee_salary_structures.active.first
  end

  def set_monthly_salary
    @monthly_salary = @employee.employee_monthly_salaries.find(params[:id])
  end

  def monthly_salary_params
    params
      .require(:employee_monthly_salary)
      .permit(
        :month_input,
        :basic_salary,
        :allowances,
        :deductions,
        :notes
      )
  end
end
