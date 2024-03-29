require 'rails_helper'

feature 'User can put out product from basket_products' do

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
    scenario 'have remove link' do
      within "#basket_product_#{basket_product.id}" do
        expect(page).to have_link 'remove'
      end
    end

    scenario 'remove product' do
      within "#basket_product_#{basket_product.id}" do
        within ".count" do
          expect(page).to have_content basket_product.count
        end
        click_on 'remove'
      end
      within "#basket_product_#{basket_product.id}" do
        within ".count" do
          expect(page).to have_content basket_product.count - 1
          expect(page).to_not have_content basket_product.count
        end
      end
    end
  end
end