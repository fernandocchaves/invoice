require File.expand_path("helper")

describe Address do
    
    def address(options = {})
        @address ||= begin
            defaults = {
                city: "Belo Horizonte",
                country: "Brasil",
                phone: "(31) 32423423",
                street: "Alameda do sol, 25",
                postal_code: "3043434"
            }.merge(options)

            Address.new(defaults)
        end
    end

    it 'should be initialized wirh many attributes at once' do
        assert_equal "Belo Horizonte", address.city
        assert_equal "Brasil", address.country
        assert_equal "(31) 32423423", address.phone
        assert_equal "Alameda do sol, 25", address.street
        assert_equal "3043434", address.postal_code
    end

    it 'should know how to print hinself' do
        assert_equal "Alameda do sol, 25. Belo Horizonte - Brasil - 3043434", address.to_s
    end

    it 'should know when he is complete or not' do
        assert address.complete?
        address.city = nil
        assert !address.complete?
    end

end