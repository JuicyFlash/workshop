class Basket < ApplicationRecord

  has_many :products, foreign_key: 'basket_id', class_name: 'BasketProduct', dependent: :destroy
  belongs_to :user, optional: true
  def put_product(placed_product)
    @product_in_basket = products.find_by(product_id: placed_product.id)
    if @product_in_basket.nil?
      @product_in_basket = products.build
      @product_in_basket.product = placed_product
    else
      @product_in_basket.count = @product_in_basket.count + 1
    end
    @product_in_basket.save
    @product_in_basket
  end
  def put_product_out(removed_product)
    @product_in_basket = products.find_by(product_id: removed_product.id)
    return if @product_in_basket.nil?

    if @product_in_basket.count > 1
      @product_in_basket.count = @product_in_basket.count - 1
      @product_in_basket.save
    else
      @product_in_basket.count = @product_in_basket.count - 1
      purge_product(@product_in_basket)
    end
    @product_in_basket
  end
  def purge_product(purged_product)
    @product_in_basket ||= products.find_by(product_id: purged_product.id)
    return if @product_in_basket.nil?

    @product_in_basket.destroy

    @product_in_basket
  end
  def products_count
    products.sum(:count)
  end
end
