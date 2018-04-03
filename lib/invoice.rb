require 'date'
require 'forwardable'

class Invoice extend Forwardable
    
    attr_accessor :id, :currency, :issue_date, :due_date, 
        :tax, :discount, :customer, :owner, :services

    def initialize(options = {})
        @id = options[:id]
        @issue_date = options[:issue_date]
        @due_date = options[:due_date]
    end

    def currency
        @currency ||= "R$"
    end

    def tax
        @tax ||= 0.06
    end

    def discount
        @discount ||= 0
    end

    def subtotal
        services.inject(0) { |sum, item| sum + item.amount }
    end

    def amount
        (subtotal * tax) + subtotal - discount
    end

    def to_pdf(destination = ".")
        PDFGenerator.new(self).create!(destination)
    end

    def_delegator :customer, :name, :customer_name
    def_delegator :customer, :address, :customer_address
    def_delegator :owner, :name, :owner_name
    def_delegator :owner, :address, :owner_address

end