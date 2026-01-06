class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /companies/:company_id/employees
  def index
    @employees = @company.employees.order(:first_name)
  end

  # GET /companies/:company_id/employees/:id
  def show
  end

  # GET /companies/:company_id/employees/new
  def new
    @employee = @company.employees.build
  end

  # POST /companies/:company_id/employees
  def create
    @employee = @company.employees.build(employee_params)
    @employee.user = current_user
    if @employee.save
      redirect_to company_employees_path(@company), notice: "Employee created successfully."
    else
      render :new
    end
  end

  # GET /companies/:company_id/employees/:id/edit
  def edit
  end

  # PATCH/PUT /companies/:company_id/employees/:id
  def update
    if @employee.update(employee_params)
      redirect_to company_employees_path(@company), notice: "Employee updated successfully."
    else
      render :edit
    end
  end

  # DELETE /companies/:company_id/employees/:id
  def destroy
    @employee.destroy
    redirect_to company_employees_path(@company), notice: "Employee deleted successfully."
  end

  private

  def set_company
    # @company = current_user.companies.find(params[:company_id])
    @company = current_user.companies.first
  end

  def set_employee
    @employee = @company.employees.find(params[:id])
  end

  # Future goal
  def authorize_company!
    # implicit authorization via current_user.companies
    # raises ActiveRecord::RecordNotFound if unauthorized
  end

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :phone_number, :email, :aadhaar_number, 
      :pan_number, :designation, :department, :joining_date, :salary, 
      :employee_status, :address, :notes
    )
  end
end
