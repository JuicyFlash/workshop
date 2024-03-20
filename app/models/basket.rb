class Basket < ApplicationRecord

  has_many :products, foreign_key: 'basket_id', class_name: 'BasketProduct', dependent: :destroy
  belongs_to :user
  def put_product(placed_product)
    @product_in_basket = products.find_by(product_id: placed_product.id)
    if @product_in_basket.nil?
      @product_in_basket = products.build
      @product_in_basket.product = placed_product
    else
      @product_in_basket.count = @product_in_basket.count + 1
    end
    @product_in_basket.save
  end
  def put_product_out(removed_product)
    @product_in_basket = products.find_by(product_id: removed_product.id)
    return if @product_in_basket.nil?

    if @product_in_basket.count > 1
      @product_in_basket.count = @product_in_basket.count - 1
      @product_in_basket.save
    else
      purge_product(@product_in_basket)
    end
  end
  def purge_product(purged_product)
    @product_in_basket ||= products.find_by(product_id: purged_product.id)
    return if @product_in_basket.nil?

    @product_in_basket.destroy
  end
end
