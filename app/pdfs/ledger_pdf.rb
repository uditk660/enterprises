# app/pdfs/ledger_pdf.rb
class LedgerPdf
  require 'prawn'
  require 'prawn/table'

  def initialize(entries, from_date, to_date)
    @entries = entries
    @from_date = from_date
    @to_date = to_date
    @pdf = Prawn::Document.new(page_size: 'A4', margin: [50, 50, 50, 50])
    
    header
    ledger_table
    add_page_numbers
  end

  # Header of the PDF
  def header
    @pdf.text Company.first.name, size: 18, style: :bold, align: :center # Here company name should be current company
    @pdf.move_down 5
    @pdf.text "Ledger Statement", size: 14, style: :bold, align: :center
    @pdf.move_down 5
    @pdf.text "From #{@from_date.strftime('%d-%m-%Y')} To #{@to_date.strftime('%d-%m-%Y')}", size: 12, align: :center
    @pdf.move_down 20
  end

  # Ledger table with running balance
  def ledger_table
    rows = [["Date", "Invoice", "Customer", "Debit", "Credit", "Balance"]]
    balance = 0.0

    @entries.each do |entry|
      balance += entry.debit.to_f
      balance -= entry.credit.to_f

      rows << [
        entry.entry_date.strftime("%d-%m-%Y"),                     # entry date
        entry.invoice.present? ? entry.invoice.invoice_number : "-", # invoice number
        entry.customer.present? ? entry.customer.name : "Walk-in Customer",
        entry.debit.present? ? sprintf("%.2f", entry.debit) : "-",
        entry.credit.present? ? sprintf("%.2f", entry.credit) : "-",
        sprintf("%.2f", balance)
      ]
    end

    @pdf.table(
      rows,
      header: true,
      row_colors: ["F0F0F0", "FFFFFF"],
      width: @pdf.bounds.width,
      cell_style: { size: 10, padding: [5, 5, 5, 5] }
    )
  end

  # Add page numbers at bottom center
  def add_page_numbers
    @pdf.number_pages "<page> / <total>", {
      at: [0, 15],                 # y = 15 points from bottom
      width: @pdf.bounds.width,    # full width for center alignment
      align: :center,
      start_count_at: 1,
      size: 9,
      style: :italic
    }
  end

  # Render PDF
  def render
    @pdf.render
  end
end
