class PaymentReceiptPdf
  require 'prawn'
  require 'prawn/table'

  def initialize(payment)
    @payment = payment
    @pdf = Prawn::Document.new(
      page_size: 'A4',
      margin: [50, 50, 50, 50]
    )

    header
    payment_details
    linked_records
    ledger_note
    footer
  end

  def render
    @pdf.render
  end

  private

  def header
    @pdf.text "Payment Receipt",
              size: 18,
              style: :bold,
              align: :center

    @pdf.move_down 5

    @pdf.text "Payment details & ledger impact",
              size: 11,
              align: :center

    @pdf.move_down 20
  end

  def payment_details
    table_data = [
      ["Date", @payment.payment_date.strftime("%d-%b-%Y")],
      ["Amount", "Rs. #{format('%.2f', @payment.amount)}"],
      ["Payment Mode", @payment.payment_mode],
      ["Reference No", @payment.reference.presence || "-"]
    ]

    section("Payment Details", table_data)
  end

  def linked_records
    table_data = [
      ["Customer", @payment.customer.name],
      ["Invoice",
        @payment.invoice.present? ?
          @payment.invoice.invoice_number :
          "Advance Payment"]
    ]

    section("Linked Records", table_data)
  end

  def ledger_note
    @pdf.move_down 10

    @pdf.text "Ledger Impact",
              size: 13,
              style: :bold

    @pdf.move_down 5

    @pdf.text(
      "This payment is recorded as a CREDIT entry in the customer ledger.",
      size: 11,
      color: "555555"
    )
  end

  def section(title, rows)
    @pdf.text title,
              size: 13,
              style: :bold

    @pdf.move_down 6

    @pdf.table(
      rows,
      width: @pdf.bounds.width,
      cell_style: { size: 11, padding: 6 }
    ) do
      cells.borders = [:bottom]
      columns(0).font_style = :bold
    end

    @pdf.move_down 15
  end

  def footer
    @pdf.number_pages(
      "Page <page>",
      at: [0, -10],
      width: @pdf.bounds.width,
      align: :center,
      size: 9
    )
  end
end
