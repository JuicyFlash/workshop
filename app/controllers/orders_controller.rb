class OrdersController < ApplicationController

  before_action :find_basket, only: %i[create]

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id if current_user.present?
    @basket.products.find_each do |product|
       @order.order_products.new(product_id: product.id)
    end
    if  @order.save
      @basket.basket_products.destroy_all
      flash[:success] = "Заказ оформлен #{@order.id}"
      redirect_to(root_path)
    end
  end

  private

  def order_params
    params.require(:order).permit(detail_attributes: [:first_name, :last_name, :city, :phone, :street, :house])
  end

  def find_basket
    @basket = basket_service.basket
  end
end
