class BillsController < ApplicationController
  def index
    @bills = Bill.includes(:customer).order(created_at: :desc)
  end

  def new
    @bill = Bill.new(date: Date.today)
    @bill.bill_items.build
  end

  def create
    @bill = Bill.new(bill_params)

    Bills::Calculator.new(@bill).call

    if @bill.save
      redirect_to @bill, notice: 'Bill created successfully'
    else
      render :new
    end
  end

  def show
    @bill = Bill.find(params[:id])
  end

  private

  def bill_params
    params.require(:bill).permit(
      :bill_number, :date, :company_id, :customer_id,
      bill_items_attributes: [
        :product_id, :quantity, :rate, :tax_percentage, :_destroy
      ]
    )
  end
end