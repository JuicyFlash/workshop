class BasketsController < ApplicationController

  before_action :find_basket, only: %i[show]

  def show
    @order = Order.new
    @order_detail = OrderDetail.new
    @order.detail = @order_detail
    @basket_products = @basket.basket_products
  end

  private

  def find_basket
    @basket = basket_service.basket
  end
end
