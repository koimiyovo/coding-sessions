# frozen_string_literal: true

class Ticket
  def initialize(command, printer = TextTicketPrinter.new(self))
    @command = command
    @printer = printer
  end

  def print
    @printer.print_ticket
  end

  def products_summaries
    @products_summaries ||= @command.command_items.map do |command_item|
      {
        name: command_item.product.name,
        total_ttc: command_item.total_ttc,
        quantity: command_item.quantity
      }
    end
  end

  def total_ttc
    @command.total_ttc
  end

  def total_taxes
    @command.total_taxes
  end
end
