class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.includes(:company, :customer).order(created_at: :desc)
  end

  def show
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_date = Date.today
    @invoice.invoice_number = Invoice.set_invoice_number
    @invoice.invoice_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)
    calculate_totals(@invoice)
    if @invoice.save
      redirect_to @invoice, notice: "Invoice created successfully."
    else
      render :new
    end
  end

  def edit
    @invoice.invoice_items.build if @invoice.invoice_items.empty?
  end

  def update
    @invoice.assign_attributes(invoice_params)
    calculate_totals(@invoice)
    if @invoice.save
      redirect_to @invoice, notice: "Invoice updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path, notice: "Invoice deleted successfully."
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(
      :company_id, :customer_id, :invoice_number, :invoice_date, :subtotal, :gst_total, :round_off, :total_amount,
      invoice_items_attributes: [:id, :product_name, :dispatch_date, :challan_number, :destination, :weight, :amount, :_destroy]
    )
  end

  def calculate_totals(invoice)
    subtotal = invoice.invoice_items.sum(&:amount)
    gst_total = subtotal * 0.18 # example 18% GST
    total = subtotal + gst_total
    invoice.subtotal = subtotal
    invoice.gst_total = gst_total
    invoice.round_off = total - total.floor
    invoice.total_amount = total.round
  end
end