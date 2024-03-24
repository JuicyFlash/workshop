class ProductsController < ApplicationController

  before_action :find_product, only: %i[put_in_basket purge_from_basket put_out_basket]
  before_action :find_basket, only: %i[index put_in_basket purge_from_basket put_out_basket]
  def index
    @products = Product.all
  end
  def put_in_basket
    @basket_product = @basket.put_product(@product)

    respond_with_turbo([turbo_update_nav_basket, turbo_update_basket_product])
  end
  def put_out_basket
    @basket_product = @basket.put_product_out(@product)

    if @basket_product.count > 0
      respond_with_turbo([turbo_update_nav_basket, turbo_update_basket_product])
    else
      respond_with_turbo([turbo_update_nav_basket, turbo_remove_basket_product])
    end
  end
  def purge_from_basket
    @basket_product = @basket.purge_product(@product)

    respond_with_turbo([turbo_update_nav_basket, turbo_remove_basket_product])
  end

  private
  def find_product
    @product = Product.find_by(id: params[:id])
  end
  def find_basket
    return if current_user.nil?

    @basket = current_user.basket
  end
  def respond_with_turbo(streams)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: streams }
      format.html { redirect_to basket_path(@basket) }
    end
  end
  def turbo_update_basket_product
    turbo_stream.update(@basket_product, partial: 'baskets/basket_product', locals: { basket_product: @basket_product })
  end
  def turbo_remove_basket_product
    turbo_stream.remove(@basket_product)
  end
  def turbo_update_nav_basket
    turbo_stream.update('nav_basket', partial: 'shared/nav_basket')
  end
end
