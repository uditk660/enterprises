# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :ledger]

  def index
    @customers = Customer.order(:name)
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "Customer created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer updated successfully"
    else
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path, notice: "Customer deleted"
    else
      redirect_to customers_path, alert: "Customer is linked to invoices"
    end
  end

  # def ledger
  #   @customer = Customer.find(params[:id])
  #   all_entries = @customer.ledger_entries.order(:entry_date, :id)
  #   # ✅ CORRECT closing balance (authoritative)
  #   @closing_balance = all_entries.last&.balance || 0
  #   # ✅ Paginated entries only for table
  #   @ledger_entries = all_entries.page(params[:page]).per(20)
  # end

  def ledger
    @customer = Customer.find(params[:id])

    from_date = params[:from_date].presence&.to_date
    to_date   = params[:to_date].presence&.to_date

    all_entries = @customer.ledger_entries.order(:entry_date, :id)

    # 🔹 Opening Balance (Carry Forward)
    if from_date
      @opening_balance = all_entries
        .where("entry_date < ?", from_date)
        .sum("debit - credit")

      scoped_entries = all_entries.where(entry_date: from_date..(to_date || Date.today))
    else
      @opening_balance = 0
      scoped_entries = all_entries
    end

    # 🔹 Paginated entries ONLY
    @ledger_entries = scoped_entries.page(params[:page]).per(20)

    # 🔹 Closing balance (FULL ledger truth)
    @closing_balance = all_entries.sum("debit - credit")
  end
  
  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def calculate_opening_balance
    0 # future: date-wise opening balance
  end

  def customer_params
    params.require(:customer).permit(
      :name,
      :address,
      :phone,
      :gst_number
    )
  end
end