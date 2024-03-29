require 'rails_helper'

feature 'User can add product in basket' do

  describe 'Authenticated user' do
    given!(:user) { create(:user) }
    given!(:product) { create(:product) }
    given!(:basket) { create(:basket, user: user) }

    background do
      sign_in(user)
      visit products_path
    end
    scenario 'add product' do
      click_on 'add'
      visit  basket_path(basket)

      expect(page).to have_content  product.title
    end
  end
end
