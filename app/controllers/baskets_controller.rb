class BasketsController < ApplicationController

  before_action :find_basket, only: %i[show]

  def show
    @basket_products = @basket.products
  end

  private

  def find_basket
    @basket = current_user.basket
  end
end
