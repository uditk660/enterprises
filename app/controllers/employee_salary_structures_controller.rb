class EmployeeSalaryStructuresController < ApplicationController
  before_action :set_company
  before_action :set_employee
  before_action :set_salary_structure, only: [:show, :edit, :update, :destroy]

  def index
    @salary_structures =@employee.employee_salary_structures.order(effective_from: :desc)
  end

  def show
  end

  def new
    @salary_structure = @employee.employee_salary_structures.new
  end

  def create
    @salary_structure =
      @employee.employee_salary_structures.new(salary_structure_params)

    if @salary_structure.save
      redirect_to company_employee_employee_salary_structures_path(@company, @employee),
        notice: "Salary structure added successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @salary_structure.update(salary_structure_params)
      redirect_to company_employee_employee_salary_structure_path(
                    @company, @employee, @salary_structure),
        notice: "Salary structure updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @salary_structure.destroy
    redirect_to company_employee_employee_salary_structures_path(@company, @employee),
      notice: "Salary structure removed"
  end

  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_employee
    @employee = @company.employees.find(params[:employee_id])
  end

  def set_salary_structure
    @salary_structure =
      @employee.employee_salary_structures.find(params[:id])
  end

  def salary_structure_params
    params.require(:employee_salary_structure).permit(
      :basic,
      :hra,
      :allowances,
      :deductions,
      :effective_from
    )
  end
end
