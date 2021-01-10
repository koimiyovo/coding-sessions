# frozen_string_literal: true

class Type
  attr_reader :tax_percentage

  def initialize(name: nil, tax_percentage: nil)
    @name = name
    @tax_percentage = tax_percentage
  end
end
