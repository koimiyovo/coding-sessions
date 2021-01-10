# frozen_string_literal: true

class TypeWithTax < Type
  class << self
    def other
      @other ||= new(name: 'other', tax_percentage: 0.10)
    end
  end
end