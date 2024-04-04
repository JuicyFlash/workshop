class OrdersController < ApplicationController

  before_action :find_basket, only: %i[create]

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id if current_user.present?
    @basket.basket_products.find_each do |basket_product|
       @order.order_products.new(product_id: basket_product.product_id, count: basket_product.count)
    end
    if @order.save
      @basket.basket_products.destroy_all
      respond_to do |format|
        format.turbo_stream { flash[:notice] = "Заказ оформлен #{@order.id}" }
        format.html { flash[:notice] = "Заказ оформлен #{@order.id}" }
      end
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
