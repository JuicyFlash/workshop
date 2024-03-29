require 'rails_helper'

RSpec.describe BasketProductsController, type: :controller do

  describe 'authenticated user' do
    let(:user) { create(:user) }
    let!(:product) { create(:product) }
    let(:basket) { create(:basket, user: user) }

    before do
      login(user)
    end
    describe 'create' do
      it 'create new basket_product in user basket_products' do
        expect(BasketProduct.count).to eq 0
        post :create, params: { product_id: product, basket_product: { count: 1 } }

        expect(BasketProduct.count).to eq 1
      end
      it 'set count from params to basket_product' do
        expect(BasketProduct.count).to eq 0
        post :create, params: { product_id: product, basket_product: { count: 3 } }

        expect(BasketProduct.count).to eq 1
        expect(BasketProduct.first.count).to eq 3
      end
      it 'add count if product already exist' do
        create(:basket_product, basket: basket, product: product, count: 1)
        post :create, params: { product_id: product, basket_product: { count: 3 } }

        expect(BasketProduct.count).to eq 1
        expect(BasketProduct.first.count).to eq 4
      end
    end

    describe 'update(#add#remove)' do
      let!(:basket_product) { create(:basket_product, basket: basket, product: product, count: 3) }

      it 'add basket_products product count' do
        patch :add, params: { id: basket_product, basket_product: { count: 3 } }
        basket_product.reload

        expect(basket_product.count).to eq 6
      end
      it 'remove basket_product count' do
        patch :remove, params: { id: basket_product, basket_product: { count: 2 } }
        basket_product.reload

        expect(basket_product.count).to eq 1
      end
      it 'dont set count below 0' do
        patch :remove, params: { id: basket_product, basket_product: { count: 12 } }
        basket_product.reload

        expect(basket_product.count).to eq 0
      end
    end

    describe 'delete' do
      let!(:basket_product) { create(:basket_product, basket: basket, product: product, count: 3) }

      it 'delete basket_product' do
        expect(BasketProduct.count).to eq 1

        expect{ delete :destroy, params: { id: basket_product } }.to change(BasketProduct, :count).by(-1)
      end
    end
  end

  describe 'unauthenticated user' do
    let!(:product) { create(:product) }
    let(:basket) { create(:basket, user: nil) }
    let(:basket_service) { BasketService.new({ basket_id: basket.id },nil) }

    before do
      allow(BasketService).
        to receive(:new).
          and_return(basket_service)
    end
    describe 'create' do
      it 'create new basket_product in user basket_products' do
        expect(BasketProduct.count).to eq 0
        post :create, params: { product_id: product, basket_product: { count: 1 } }

        expect(BasketProduct.count).to eq 1
      end
      it 'set count from params to basket_product' do
        expect(BasketProduct.count).to eq 0
        post :create, params: { product_id: product, basket_product: { count: 3 } }

        expect(BasketProduct.count).to eq 1
        expect(BasketProduct.first.count).to eq 3
      end
      it 'add count if product already exist' do
        create(:basket_product, basket: basket, product: product, count: 1)
        post :create, params: { product_id: product, basket_product: { count: 3 } }

        expect(BasketProduct.count).to eq 1
        expect(BasketProduct.first.count).to eq 4
      end
    end

    describe 'update(#add#remove)' do
      let!(:basket_product) { create(:basket_product, basket: basket, product: product, count: 3) }

      it 'add basket_products product count' do
        patch :add, params: { id: basket_product, basket_product: { count: 3 } }
        basket_product.reload

        expect(basket_product.count).to eq 6
      end
      it 'remove basket_product count' do
        patch :remove, params: { id: basket_product, basket_product: { count: 2 } }
        basket_product.reload

        expect(basket_product.count).to eq 1
      end
      it 'dont set count below 0' do
        patch :remove, params: { id: basket_product, basket_product: { count: 12 } }
        basket_product.reload

        expect(basket_product.count).to eq 0
      end
    end

    describe 'delete' do
      let!(:basket_product) { create(:basket_product, basket: basket, product: product, count: 3) }

      it 'delete basket_product' do
        expect(BasketProduct.count).to eq 1

        expect{ delete :destroy, params: { id: basket_product } }.to change(BasketProduct, :count).by(-1)
      end
    end
  end
end
