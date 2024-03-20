class ProductsController < ApplicationController

  before_action :find_product, only: %i[put_in_basket purge_from_basket put_out_basket]
  before_action :find_basket, only: %i[put_in_basket purge_from_basket put_out_basket]
  def index
    @products = Product.all
  end
  def put_in_basket
    @basket.put_product(@product)
  end
  def put_out_basket
    @basket.put_product_out(@product)
  end
  def purge_from_basket
    @basket.purge_product(@product)
  end

  private
  def find_product
    @product = Product.find_by(id: params[:id])
  end
  def find_basket
    @basket = current_user.basket
  end
end
