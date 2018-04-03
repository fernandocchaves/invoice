require "forwardable"

module Addressable extend Forwardable
    attr_accessor :name, :address

    def_delegators :address, :street, :city, :country, :postal_code

    def initialize(name = nil, address = nil)
        @name, @address = name, address
    end

    def address
        @address ||= Address.new
    end
end

class Customer 
    include Addressable
end

class Owner 
    include Addressable
end