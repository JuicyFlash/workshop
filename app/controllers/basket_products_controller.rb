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
    @basket_product.save

    respond_with_turbo([turbo_update_nav_basket])
  end

  def add
    update_basket_product
  end

  def remove
    return if @basket_product.count.eql? 1

    @count = @count * (-1)
    update_basket_product
  end

  def destroy
    @basket_product.destroy

    respond_with_turbo([turbo_update_nav_basket, turbo_remove_basket_product])
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

  def respond_with_turbo(streams)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: streams }
      format.html { redirect_to basket_path(@basket) }
    end
  end

  def turbo_update_basket_product
    turbo_stream.update(@basket_product, partial: 'basket_products/basket_product', locals: { basket_product: @basket_product })
  end

  def turbo_remove_basket_product
    turbo_stream.remove(@basket_product)
  end

  def turbo_update_nav_basket
    turbo_stream.update('nav_basket', partial: 'shared/nav_basket')
  end

  def update_basket_product
    @basket_product.count = @basket_product.count + @count
    @basket_product.save

    respond_with_turbo([turbo_update_nav_basket, turbo_update_basket_product])
  end
end
