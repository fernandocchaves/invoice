require File.expand_path("helper")

describe Addressable do

    class AddressFoo
        include Addressable
    end

    before do
        @foo = AddressFoo.new
    end

    it 'has a name' do
        @foo.name = "Daniel Lopes"
        assert_equal "Daniel Lopes", @foo.name
    end

end