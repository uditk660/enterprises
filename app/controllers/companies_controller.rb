# app/controllers/companies_controller.rb
class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update]

  def index
    @companies = Company.order(:name)
  end

  def show
  end

  def new
    @company = Company.new
    @company.build_bank_account
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company, notice: "Company created successfully"
    else
      render :new
    end
  end

  def edit
    @company.build_bank_account if @company.bank_account.nil?
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company updated successfully"
    else
      render :edit
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(
      :name,
      :address,
      :phone,
      :gst_number,
      :udyam_number,
      bank_account_attributes: [
        :id,
        :bank_name,
        :account_number,
        :ifsc_code,
        :branch
      ]
    )
  end
end
