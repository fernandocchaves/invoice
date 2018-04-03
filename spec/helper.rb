$LOAD_PATH.unshift(File.dirname(__FILE__))
Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each { |f| require f }

require 'minitest/spec'
require 'minitest/autorun'
require 'date'

def make_invoice(options = {})
    @invoice ||= begin
        invoice = Invoice.new({
            id: 1,
            issue_date: Date.today,
            due_date: Date.today + 2
        }.merge(options))

        services = 1.upto(5).collect do |i|
            service = Service.new
            service.type = "System #{i}"
            service.quantity = 1
            service.unit_price = 1
            service # retorna o objeto service
        end

        invoice.services = services
        invoice
    end
end