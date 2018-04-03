class Address
    attr_accessor :city, :country, :phone, :street, :postal_code

    def initialize(params = {})
        params.each { |k,v| self.send("#{k}=", v) }
    end

    def to_s
        "#{street}. #{city} - #{country} - #{postal_code}"
    end

    def complete?
        !incomplete?
    end

    def incomplete?
        street.nil? || city.nil? || country.nil? || postal_code.nil?
    end
end