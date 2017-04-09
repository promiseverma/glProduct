require "rails_helper"

RSpec.describe Product, :type => :model do
  it "Create product" do
    product = Product.create!(name: "Product1", description: "This is rpec test", price: 2382.87)

    expect(Product.last).to eq(product)
  end

  it "Check validation product" do
    product = Product.create(name: "", description: "This is rpec test", price: 2382.8745)

    expect(product.errors.messages[:name]).to eq(["can't be blank"])
    expect(product.errors.messages[:price]).to eq(["should be either numeric or float upto two decimal places."])
  end

end