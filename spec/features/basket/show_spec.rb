require 'rails_helper'

feature 'User can view list of products in basket' do

  describe 'authenticated' do
    given!(:user) { create(:user) }
    given!(:basket) { create(:basket, user: user) }
    given!(:basket_products) { create_list(:basket_product, 4, basket: basket) }

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

  describe 'unauthenticated' do
    given!(:basket) { create(:basket, user: nil) }
    given!(:basket_products) { create_list(:basket_product, 4, basket: basket) }
    given!(:basket_service) { BasketService.new({ basket_id: basket.id },nil) }

    scenario 'show products in basket' do
      allow(BasketService).to receive(:new).and_return(basket_service)

      visit basket_path(basket)
      basket_products.each do |basket_product|
        within "#basket_product_#{basket_product.id}" do
          expect(page).to have_content basket_product.product.title
          expect(page).to have_content basket_product.count
        end
      end
    end
  end
end
