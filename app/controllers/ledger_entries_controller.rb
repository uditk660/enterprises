class LedgerEntriesController < ApplicationController
  # def export
  #   from_date = params[:from_date].present? ? Date.parse(params[:from_date]) : Date.today.beginning_of_month
  #   to_date   = params[:to_date].present?   ? Date.parse(params[:to_date])   : Date.today.end_of_month

  #   @ledger_entries = LedgerEntry.where(entry_date: from_date..to_date).order(:entry_date)

  #   respond_to do |format|
  #     format.pdf do
  #       pdf = LedgerPdf.new(@ledger_entries, from_date, to_date)
  #       send_data pdf.render, filename: "ledger_#{from_date}_to_#{to_date}.pdf",
  #                             type: "application/pdf",
  #                             disposition: "inline"
  #     end
  #   end
  # end
  def export
    from_date = params[:from_date].presence&.to_date
    to_date   = params[:to_date].presence&.to_date

    from_date ||= Date.current
    to_date   ||= Date.current

    @opening_balance = LedgerEntry.where("entry_date < ?", from_date).sum("debit - credit")

    @ledger_entries = LedgerEntry.where(entry_date: from_date..to_date).order(:entry_date)

    respond_to do |format|
      format.pdf do
       pdf = LedgerPdf.new(@ledger_entries, from_date, to_date)

        send_data pdf.render,
                  filename: "ledger_#{from_date}_to_#{to_date}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end
end