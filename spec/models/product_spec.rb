require "rails_helper"

RSpec.describe Product, :type => :model do
  it "Create product" do
    product = Product.create!(name: "Product1", description: "This is rpec test", price: 2382.87)

    expect(Product.last).to eq(product)
  end
end