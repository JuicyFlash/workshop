class ProductsController < ApplicationController

  before_action :find_basket, only: %i[index]
  def index
    @products = Product.all
    @basket_product = BasketProduct.new
  end

  private
  def find_product
    @product = Product.find_by(id: params[:id])
  end
  def find_basket
    @basket = basket_service.basket
  end
end
