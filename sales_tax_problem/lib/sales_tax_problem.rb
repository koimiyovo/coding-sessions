require 'sales_tax_problem/version'

require 'sales_tax_problem/tax_management/command'
require 'sales_tax_problem/tax_management/command_item'
require 'sales_tax_problem/tax_management/type'
require 'sales_tax_problem/tax_management/type_with_tax'
require 'sales_tax_problem/tax_management/type_without_tax'
require 'sales_tax_problem/tax_management/import_type'
require 'sales_tax_problem/tax_management/product'

require 'sales_tax_problem/ticket_printing/ticket'
require 'sales_tax_problem/ticket_printing/ticket_printer'
require 'sales_tax_problem/ticket_printing/text_ticket_printer'

require 'sales_tax_problem/utils/round_util'

module SalesTaxProblem
  class Error < StandardError; end
  # Your code goes here...
end
