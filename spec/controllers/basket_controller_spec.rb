require 'rails_helper'

RSpec.describe BasketsController, type: :controller do
  describe 'GET #show' do
    let!(:user) { create(:user) }
    let!(:basket) { user.basket }
    let(:basket_products) { create_list(:basket_product, 5, basket: basket) }

    before { login(user) }
    before { get :show, params: { id: basket } }

    it 'populates an array of all products' do
      expect(assigns(:basket_products)).to match_array(basket_products)
    end
  end
end
