require File.expand_path("helper")
require 'tmpdir'

describe Invoice do
    
    def invoice(options = {})
        @invoice ||= make_invoice(options)
    end

    it 'has R$ as currency default' do
        assert_equal "R$", invoice.currency
    end

    it 'has 0.06 tax default' do
        assert_equal 0.06, invoice.tax
    end

    it 'has 0 discount default' do
        assert_equal 0, invoice.discount
    end

    it 'should be initialized an id, due_date and issue_date' do
        invoice = Invoice.new(id: 1, issue_date: Date.today, due_date: Date.today + 10)
        assert_equal 1, invoice.id
        assert_equal Date.today, invoice.issue_date
        assert_equal Date.today + 10, invoice.due_date
    end

    describe "invoice amout calculation" do
    
        it 'has a subtotal without taxes and discounts' do
            assert_equal 5, invoice.subtotal
        end
    
        it 'should have an amount with taxes' do
            assert_equal 5.3, invoice.amount
        end

        it 'should apply discounts id avaliable' do
            invoice.discount = 1
            assert_equal 4.3, invoice.amount
        end

    end

    describe "pdf generation" do
        it 'should the pdf file in the given path' do
            invoice.customer = Customer.new("Egenial")
            invoice.owner = Customer.new("Daniel Lopes")

            Dir.mktmpdir do |dir|
                invoice.to_pdf(dir)
                expected = "#{dir}/1-egenial.pdf"
                assert File.file?(expected), "It spects a PDF file"
            end
        end
    end

    describe "#customer_name" do
        it 'delegates name to customer' do
            invoice.customer = Customer.new("Egenial")
            assert_equal "Egenial", invoice.customer_name
        end
    end

end