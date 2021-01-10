# frozen_string_literal: true

class TypeWithoutTax < Type
  class << self
    def book
      @book ||= new(name: 'book', tax_percentage: 0.0)
    end

    def food
      @food ||= new(name: 'food', tax_percentage: 0.0)
    end

    def medical_product
      @medical_product ||= new(name: 'medical_product', tax_percentage: 0.0)
    end
  end
end
