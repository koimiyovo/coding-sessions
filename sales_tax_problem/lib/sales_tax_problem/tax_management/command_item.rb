# frozen_string_literal: true

require 'forwardable'

class CommandItem
  attr_reader :quantity, :product
  extend Forwardable
  def_delegators :@product, :basic_tax, :import_tax

  def initialize(product: nil, quantity: nil)
    @product = product
    @quantity = quantity
  end

  def total_ttc
    @product.prix_ttc * @quantity
  end
end
