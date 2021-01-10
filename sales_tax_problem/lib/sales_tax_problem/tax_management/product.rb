# frozen_string_literal: true

class Product
  attr_reader :name, :type, :price

  def initialize(name: nil, type: nil, price: nil, import_type: ImportType.not_imported)
    @name = name
    @type = type
    @price = price
    @import_type = import_type
  end

  def prix_ttc
    @price + basic_tax + import_tax
  end

  def basic_tax
    RoundUtil.round_nearest_to_005(@type.tax_percentage * @price)
  end

  def import_tax
    RoundUtil.round_nearest_to_005(@import_type.tax_percentage * @price)
  end
end
