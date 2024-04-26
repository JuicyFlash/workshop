module ShopMainHelper
  def nav_basket_price(basket)
    '100000р'
  end
  def nav_basket_products(basket)
    "products: #{basket.products_count}"
  end
end
