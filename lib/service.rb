class Service
    attr_accessor :type, :description, :quantity, :unit_price 

    def quantity
        @quantity = 1 
    end

    def amount
        @unit_price * @quantity
    end
end