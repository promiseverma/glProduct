class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def checkout
    respond_to do |format|
      if params["products_list"].nil? && session[:token].nil?
        format.html{redirect_to products_url}
      else
        if params["products_list"].present?
          session[:token] = generate_token
          OrderSession.create(products_list: params["products_list"], token: session[:token])
          @arr = params["products_list"].split(',')
          @order = Product.where(id: @arr.uniq)
        else
          order = OrderSession.find_by_token(session[:token])
          @arr = order.products_list.split(',')
          @order = Product.where(id: @arr.uniq)
        end
        format.html
      end
    end 
  end

  def order
    respond_to do |format|
      if rand(2..15).even?
        order = OrderSession.find_by_token(session[:token])
        @arr = order.products_list.split(',')
        @order = Product.where(id: @arr.uniq)
        transaction = {}
        transaction["id"] = "txn_1A6GLtK3DDW0KDALzgG5oPEc"
        transaction["amount"] = params["price"]
        @transaction = transaction
        reset_session
        format.html
      else
        format.html { redirect_to products_checkout_path, notice: 'Payment is failed please try after some time.' }
      end
    end
  end

  private
    #Generate token to save cart data
    def generate_token
      o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      token = (0...50).map { o[rand(o.length)] }.join
      return token
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
