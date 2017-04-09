require "rails_helper"

RSpec.describe ProductsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the posts into @products" do
      product1, product2 = Product.create!(name: "Product1", description: "This is rpec test", price: 2382.87), Product.create!(name: "Product1", description: "This is rpec test", price: 2382.87)
      get :index

      expect(assigns(:products)).to match_array([product1, product2])
    end

    it "loads details of product for show page" do
      product = Product.create!(name: "Product1", description: "This is rpec test", price: 2382.87)
      get :show, id: product.id

      expect(assigns(:product)).to eq(product)
    end


  end

  describe "#checkout" do
     it "loads details of products for checkout page" do
      post :checkout, :products_list => "2,3,4,3"

      order = Product.where(id: [2,3,4])

      expect(assigns(:arr)).to eq(["2","3","4","3"])
      expect(assigns(:order)).to eq(order)
    end
  end
end