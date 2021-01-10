class TextTicketPrinter < TicketPrinter
  def print_ticket
    lines = []
    @ticket.products_summaries.each do |summary|
      lines << "#{summary[:quantity]} #{summary[:name]}: #{with_format(summary[:total_ttc])}"
    end
    lines << "Sales Taxes: #{with_format(@ticket.total_taxes)}"
    lines << "Total: #{with_format(@ticket.total_ttc)}"

    lines.join("\n")
  end

  private

  def with_format(number)
    format('%.2f', number)
  end
end