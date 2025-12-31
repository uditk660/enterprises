module Bills
  class Calculator
    def initialize(bill)
      @bill = bill
    end

    def call
      subtotal = 0
      tax = 0

      @bill.bill_items.each do |item|
        line_amount = item.quantity * item.rate
        line_tax = (line_amount * item.tax_percentage) / 100

        item.line_total = line_amount + line_tax

        subtotal += line_amount
        tax += line_tax
      end

      total = subtotal + tax
      rounded_total = total.round(2)

      @bill.subtotal   = subtotal
      @bill.tax_amount = tax
      @bill.round_off  = rounded_total - total
      @bill.total      = rounded_total
    end
  end
end