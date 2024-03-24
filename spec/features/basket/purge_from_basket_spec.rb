require 'rails_helper'

feature 'User can purge product from basket' do

  describe 'Authenticated user' do
    given!(:user) { create(:user) }
    given!(:basket_product) { create(:basket_product, basket: user.basket) }

    background do
      sign_in(user)
      basket_product.count = 3
      basket_product.save
      visit basket_path(user.basket)
    end
    scenario 'have purge link' do
      within "#basket_product_#{basket_product.id}" do
        expect(page).to have_link 'purge'
      end
    end

    scenario 'purge product' do
      within "#basket_product_#{basket_product.id}" do
        expect(page).to have_content basket_product.product.title
        click_on 'purge'
      end

      expect(page).to_not have_content basket_product.product.title
    end
  end
end
