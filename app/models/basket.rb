class Basket < ApplicationRecord

  has_many :basket_products, foreign_key: 'basket_id', class_name: 'BasketProduct', dependent: :destroy
  has_many :products, through: :basket_products
  belongs_to :user, optional: true
  def product_exist_in_basket?(product)
    !(basket_products.find_by(product_id: product.id).nil?)
  end
  def products_count
    products.sum(:count)
  end
  def copy_basket_products_from(source_basket_id)
    BasketProduct.transaction do
      BasketProduct.where(basket_id: source_basket_id).update_all(basket_id: id)
    end
  end
end
