class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show]
  before_action :set_customer

  def index
    # binding.pry
    @payments = @customer.payments.order(payment_date: :desc)
  end

  def new
    @payment = @customer.payments.new(payment_date: Date.today)
    @open_invoices = @customer.invoices.open_invoices
  end


  def create
    @payment = @customer.payments.new(payment_params)
    
    if @payment.save
      redirect_to customer_payments_path(@customer), notice: "Payment recorded successfully."
    else
      @open_invoices = @customer.invoices.open_invoices
      render :new
    end
  end

  def show
    @payment = @customer.payments.find(params[:id])
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def payment_params
    params.require(:payment).permit(
      :customer_id,
      :invoice_id,
      :payment_date,
      :amount,
      :payment_mode,
      :reference
    )
  end
end
