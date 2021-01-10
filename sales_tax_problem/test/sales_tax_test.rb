# frozen_string_literal: true

require 'test_helper'

class SalesTaxTest < Minitest::Test
  def test_basic_tax_with_no_products_calcul
    # Given
    command_items = []
    commande = Command.new(command_items)

    # When
    ticket = Ticket.new(commande)

    # Then
    refute_nil ticket.print
  end

  def test_basic_tax_with_one_product_without_tax_calcul
    # Given
    command_items = [CommandItem.new(product: Product.new(name: 'book', type: TypeWithoutTax.book, price: 12.49), quantity: 2)]
    commande = Command.new(command_items)

    # When
    ticket = Ticket.new(commande)

    # Then
    refute_nil ticket.print
    assert_equal "2 book: 24.98\nSales Taxes: 0.00\nTotal: 24.98", ticket.print
  end

  def test_basic_tax_with_one_product_with_tax_calcul
    # Given
    command_items = [CommandItem.new(product: Product.new(name: 'music CD', type: TypeWithTax.other, price: 14.99), quantity: 1)]
    commande = Command.new(command_items)

    # When
    ticket = Ticket.new(commande)

    # Then
    refute_nil ticket.print
    assert_equal "1 music CD: 16.49\nSales Taxes: 1.50\nTotal: 16.49", ticket.print
  end

  def test_basic_with_products_with_tax_and_without_tax_calcul
    # Given
    book = CommandItem.new(product: Product.new(name: 'book', type: TypeWithoutTax.book, price: 12.49), quantity: 2)
    music = CommandItem.new(product: Product.new(name: 'music CD', type: TypeWithTax.other, price: 14.99), quantity: 1)
    chocolate_bar = CommandItem.new(product: Product.new(name: 'chocolate bar', type: TypeWithoutTax.food, price: 0.85), quantity: 1)

    command_items = [book, music, chocolate_bar]
    commande = Command.new(command_items)

    expected_ticket = [].tap do |content|
      content << '2 book: 24.98'
      content << '1 music CD: 16.49'
      content << '1 chocolate bar: 0.85'
      content << 'Sales Taxes: 1.50'
      content << 'Total: 42.32'
    end

    # When
    ticket = Ticket.new(commande)

    # Then
    refute_nil ticket.print
    assert_equal expected_ticket.join("\n"), ticket.print
  end

  def test_imported_tax_with_one_product_without_tax_calcul
    # Given
    chocolate_bar_box = CommandItem.new(product: Product.new(name: 'imported box of chocolates', type: TypeWithoutTax.food,
                                                             price: 10.00, import_type: ImportType.imported), quantity: 1)
    command_items = [chocolate_bar_box]
    commande = Command.new(command_items)


    # When
    ticket = Ticket.new(commande)

    # Then
    refute_nil ticket.print
    assert_equal "1 imported box of chocolates: 10.50\nSales Taxes: 0.50\nTotal: 10.50", ticket.print
  end

  def test_imported_tax_with_one_product_with_tax_calcul
    # Given
    chocolate_bar_box = CommandItem.new(product: Product.new(name: 'imported box of chocolates', type: TypeWithoutTax.food,
                                                             price: 10.00, import_type: ImportType.imported), quantity: 1)
    bottle_of_perfume = CommandItem.new(product: Product.new(name: 'imported bottle of perfume', type: TypeWithTax.other,
                                                             price: 47.50, import_type: ImportType.imported), quantity: 1)
    command_items = [chocolate_bar_box, bottle_of_perfume]
    commande = Command.new(command_items)

    expected_ticket = [].tap do |content|
      content << '1 imported box of chocolates: 10.50'
      content << '1 imported bottle of perfume: 54.65'
      content << 'Sales Taxes: 7.65'
      content << 'Total: 65.15'
    end


    # When
    ticket = Ticket.new(commande)

    # Then
    refute_nil ticket.print
    assert_equal expected_ticket.join("\n"), ticket.print
  end

  def test_imported_tax_with_products_without_tax_and_with_tax_calcul
    # Given
    bottle_of_perfume = CommandItem.new(product: Product.new(name: 'imported bottle of perfume', type: TypeWithTax.other,
                                                             price: 27.99, import_type: ImportType.imported), quantity: 1)

    not_imported_bottle_of_perfume = CommandItem.new(product: Product.new(name: 'bottle of perfume', type: TypeWithTax.other,
                                                             price: 18.99, import_type: ImportType.not_imported), quantity: 1)

    packet_of_headache_pills = CommandItem.new(product: Product.new(name: 'packet of headache pills', type: TypeWithoutTax.medical_product,
                                                                          price: 9.75, import_type: ImportType.not_imported), quantity: 1)

    chocolate_bar_box = CommandItem.new(product: Product.new(name: 'imported box of chocolates', type: TypeWithoutTax.food,
                                                             price: 11.25, import_type: ImportType.imported), quantity: 3)


    command_items = [bottle_of_perfume, not_imported_bottle_of_perfume, packet_of_headache_pills, chocolate_bar_box]
    commande = Command.new(command_items)

    expected_ticket = [].tap do |content|
      content << '1 imported bottle of perfume: 32.19'
      content << '1 bottle of perfume: 20.89'
      content << '1 packet of headache pills: 9.75'
      content << '3 imported box of chocolates: 35.40'
      content << 'Sales Taxes: 6.65'
      content << 'Total: 98.23'
    end

    # When
    ticket = Ticket.new(commande)

    # Then
    refute_nil ticket.print
    assert_equal expected_ticket.join("\n"), ticket.print
  end
end
