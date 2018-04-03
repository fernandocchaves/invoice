require 'rubygems'
require 'prawn/table'
require 'pathname'

class PDFGenerator

  attr_accessor :invoice

  def initialize(invoice)
    @invoice = invoice
  end

  def create!(destination = ".")
    path = Pathname.new(destination).join(file_name)
    Prawn::Document.generate(path) { |pdf| draw(pdf) }
  end

private

  def draw(pdf)
    pdf.text "Invoice ##{invoice.id}", :size => 30, :style => :bold

    pdf.move_down(5)

    pdf.text "From: #{invoice.owner_name}"
    pdf.text "Address: #{invoice.owner_address}" unless invoice.owner_address.complete?

    pdf.move_down(5)

    pdf.text "To: #{invoice.customer_name}"
    pdf.text "Address: #{invoice.customer_address}" unless invoice.customer_address.complete?

    pdf.move_down(30)

    items = invoice.services.map do |item|
      [
        item.type,
        item.description,
        item.quantity,
        item.unit_price
      ]
    end

    header = ["Type", "Description", "Quantity", "Unit Price"]

    pdf.table([header] + items, :header => true, :cell_style => { :padding => 12 })
    pdf.move_down(10)
    pdf.text "Subtotal: #{invoice.currency} #{invoice.subtotal}", :size => 12, :style => :bold
    pdf.move_down(2)
    pdf.text "Total: #{invoice.currency} #{invoice.amount}", :size => 16, :style => :bold
  end

  def file_name
    name = invoice.customer_name.downcase.gsub(" ", "-")
    "#{invoice.id}-#{name}.pdf"
  end

end