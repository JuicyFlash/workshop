require 'rails_helper'

RSpec.describe BasketsController, type: :controller do
  describe 'GET #show' do
    describe 'authenticated user' do
      let!(:user) { create(:user) }
      let!(:basket) { create(:basket, user: user) }
      let(:basket_products) { create_list(:basket_product, 5, basket: basket) }

      before do
        login(user)
        get :show, params: { id: basket }
      end
      it 'populates an array of all products' do
        expect(assigns(:basket_products)).to match_array(basket_products)
      end
    end

    describe 'unauthenticated user' do
      let!(:basket) { create(:basket, user: nil) }
      let(:basket_products) { create_list(:basket_product, 5, basket: basket) }
      let(:basket_service) { BasketService.new({ basket_id: basket.id },nil) }

      before do
        allow(BasketService).to receive(:new).and_return(basket_service)
        get :show, params: { id: basket }
      end
      it 'populates an array of all products' do
        expect(assigns(:basket_products)).to match_array(basket_products)
      end
    end
  end
end
