require 'rails_helper'

feature 'User can view list of products in his basket' do
  given!(:user) { create(:user) }
  given!(:basket_products) { create_list(:basket_product, 4, basket: user.basket) }

  scenario 'show products in basket' do
    sign_in(user)
    visit basket_path(user.basket)
    basket_products.each do |basket_product|
      within "#basket_product_#{basket_product.id}" do
        expect(page).to have_content basket_product.product.title
        expect(page).to have_content basket_product.count
      end
    end
  end
end
