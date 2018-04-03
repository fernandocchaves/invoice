require File.expand_path("helper")

describe Service do

    before do
        @service = Service.new
    end

    it 'has 1 as default quantity' do
        assert_equal 1, @service.quantity
    end

    it 'calculate amount based on unit price and quantity' do
        @service.quantity = 2
        @service.unit_price = 20

        assert_equal 40, @service.amount
    end
end