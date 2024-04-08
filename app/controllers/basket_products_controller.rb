class BasketProductsController < ApplicationController

  before_action :find_basket, only: %i[create add remove destroy]
  before_action :find_product, only: %i[create]
  before_action :get_count_from_params, only: %i[create add remove]
  before_action :find_basket_product, only: %i[add remove destroy]

  def create
    if @basket.product_exist_in_basket?(@product)
      @basket_product = @basket.basket_products.find_by(product_id: @product.id)
      @basket_product.count = @basket_product.count + @count
    else
      @basket_product = @basket.basket_products.build(product_id: @product.id, count: @count)
    end

    if @basket_product.save
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Товар добавлен в корзину" }
        format.html { redirect_to root_path, notice: "Товар добавлен в корзину" }
      end
    end
  end

  def add
    update_basket_product

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to basket_path(@basket) }
    end
  end

  def remove
    return if @basket_product.count.eql? 1

    @count = @count * (-1)
    update_basket_product

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to basket_path(@basket) }
    end
  end

  def destroy
    @basket_product.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to basket_path(@basket) }
    end
  end

  private

  def get_count_from_params
    @count = params[:basket_product][:count].to_i
  end

  def find_basket
    @basket = basket_service.basket
  end

  def find_basket_product
    @basket_product = BasketProduct.find_by(id: params[:id])
  end

  def find_product
    @product = Product.find_by(id: params[:product_id])
  end

  def update_basket_product
    @basket_product.count = @basket_product.count + @count
    @basket_product.save
  end
end
