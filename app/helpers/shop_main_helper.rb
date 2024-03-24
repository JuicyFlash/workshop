module ShopMainHelper
  def nav_basket(basket)
    "Basket #{ basket.products_count }"
  end
end
