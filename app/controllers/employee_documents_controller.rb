class EmployeeDocumentsController < ApplicationController
  before_action :set_company
  before_action :set_employee
  before_action :set_document, only: [:destroy]

  def index
    @documents = @employee.employee_documents
    @document  = @employee.employee_documents.new
  end

  def create
    @document = @employee.employee_documents.new(document_params)

    if @document.save
      redirect_to company_employee_employee_documents_path(@company, @employee), notice: "Document uploaded successfully"
    else
      @documents = @employee.employee_documents
      render :index
    end
  end

  def destroy
    @document.destroy
    redirect_to company_employee_documents_path(@company, @employee),
      notice: "Document removed"
  end

  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_employee
    @employee = @company.employees.find(params[:employee_id])
  end

  def set_document
    @document = @employee.employee_documents.find(params[:id])
  end

  def document_params
    params.require(:employee_document).permit(:file, :document_type, :notes)
  end
end
