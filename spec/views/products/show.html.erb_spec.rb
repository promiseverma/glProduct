require 'rails_helper'



RSpec.describe "products/show", :type => :view do
  it "displays the products show" do
    assign(:product, Product.create(:name => "Product1", :description => "Test", :price => 321))
    render
    expect(rendered).to include("Product1")
  end
end