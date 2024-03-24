require 'rails_helper'

feature 'User can put out product from basket' do

  describe 'Authenticated user' do
    given!(:user) { create(:user) }
    given!(:basket_product) { create(:basket_product, basket: user.basket) }

    background do
      sign_in(user)
      basket_product.count = 3
      basket_product.save
      visit basket_path(user.basket)
    end
    scenario 'have put out link' do
      within "#basket_product_#{basket_product.id}" do
        expect(page).to have_link 'out'
      end
    end

    scenario 'put out product' do
      within "#basket_product_#{basket_product.id}" do
        within ".count" do
          expect(page).to have_content basket_product.count
        end
        click_on 'out'
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