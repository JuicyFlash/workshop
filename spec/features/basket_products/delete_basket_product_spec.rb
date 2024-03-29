require 'rails_helper'

feature 'User can purge product from basket_products' do

  describe 'Authenticated user' do
    given!(:user) { create(:user) }
    given!(:basket) { create(:basket, user: user) }
    given!(:basket_product) { create(:basket_product, basket: basket) }

    background do
      sign_in(user)
      basket_product.count = 3
      basket_product.save
      visit basket_path(basket)
    end
    scenario 'have purge link' do
      within "#basket_product_#{basket_product.id}" do
        expect(page).to have_link 'delete'
      end
    end

    scenario 'purge product' do
      within "#basket_product_#{basket_product.id}" do
        expect(page).to have_content basket_product.product.title
        click_on 'delete'
      end

      expect(page).to_not have_content basket_product.product.title
    end
  end
end
