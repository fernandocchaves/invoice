require File.expand_path("helper")

describe Customer do

    before do
        @customer = Customer.new
    end

    it 'has a name' do
        @customer.name = "Daniel Lopes"
        assert_equal "Daniel Lopes", @customer.name
    end

    describe "address" do
        it 'should be composed by address' do
            assert @customer.address.kind_of? Address
        end

        it 'should delegate address attibutes to customer address' do
            @customer.address = Address.new(city: "Belo Horizonte", country: "Brasil")

            assert_equal "Belo Horizonte", @customer.city
            assert_equal "Brasil", @customer.country

        end
    end
end