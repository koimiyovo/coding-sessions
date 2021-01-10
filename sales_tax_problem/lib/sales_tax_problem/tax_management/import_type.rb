# frozen_string_literal: true

class ImportType
  attr_reader :tax_percentage
  def initialize(tax_percentage = 0.0)
    @tax_percentage = tax_percentage
  end

  class << self
    def imported
      @imported ||= new(0.05)
    end

    def not_imported
      @not_imported ||= new
    end
  end
end
