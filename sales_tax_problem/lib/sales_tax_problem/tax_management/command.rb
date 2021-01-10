# frozen_string_literal: true

class Command
  attr_reader :command_items

  def initialize(command_items)
    @command_items = command_items
  end

  def total_ttc
    @command_items.map(&:total_ttc).reduce(0.00, :+)
  end

  def total_taxes
    basic_taxes + imported_taxes
  end

  private

  def basic_taxes
    @command_items.map(&:basic_tax).reduce(0.00, :+)
  end

  def imported_taxes
    @command_items.map(&:import_tax).reduce(0.00, :+)
  end
end
