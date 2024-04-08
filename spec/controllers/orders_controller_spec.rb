require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'POST #create' do
    let!(:order_detail) { build(:order_detail) }
    let(:order_create) { post :create, params: { order: { detail_attributes:
                                                            {
                                                              first_name: order_detail.first_name,
                                                              last_name: order_detail.last_name,
                                                              city: order_detail.city,
                                                              phone: order_detail.phone,
                                                              street: order_detail.street,
                                                              house: order_detail.house
                                                            } } } }
    describe 'authenticated user' do
      let!(:user) { create(:user) }
      let!(:basket) { create(:basket, user: user) }
      let!(:basket_products) { create_list(:basket_product, 5, basket: basket) }

      before do
        login(user)
      end
      it 'create new order' do
        expect{ order_create }.to change(Order, :count).by(1)

        %i[first_name last_name city phone street house].each do |field|
          expect(OrderDetail.first.send(field)).to eq(order_detail.send(field))
        end
      end
      it 'create new order with actual user' do
        order_create

        expect(Order.first.user).to eq user
      end
      it 'create order items from current basket' do
        order_create

        expect(OrderProduct.all.pluck(:product_id)).to match_array(basket_products.pluck(:product_id))
      end
      it 'clear basket products after create order' do
        expect(BasketProduct.count).to eq 5
        order_create

        expect(BasketProduct.count).to eq 0
      end
      it 'does not create new order with wrong details' do
        expect{ post :create, params: { order: { detail_attributes:
                                                   {
                                                     first_name: nil,
                                                     last_name: nil,
                                                     city: order_detail.city,
                                                     phone: order_detail.phone,
                                                     street: order_detail.street,
                                                     house: order_detail.house
                                                   } } } }.to change(Order, :count).by(0)
      end
    end

    describe 'unauthenticated user' do
      let!(:basket) { create(:basket) }
      let!(:basket_products) { create_list(:basket_product, 5, basket: basket) }

      let!(:basket_service) { BasketService.new({ basket_id: basket.id },nil) }

      before do
        allow(BasketService).to receive(:new).and_return(basket_service)
      end
      it 'create new order' do
        expect{ order_create }.to change(Order, :count).by(1)

        %i[first_name last_name city phone street house].each do |field|
          expect(OrderDetail.first.send(field)).to eq(order_detail.send(field))
        end
      end
      it 'create order items from current basket' do
        order_create

        expect(OrderProduct.all.pluck(:product_id)).to match_array(basket_products.pluck(:product_id))
      end
      it 'clear basket products after create order' do
        expect(BasketProduct.count).to eq 5
        order_create

        expect(BasketProduct.count).to eq 0
      end
      it 'does not create new order with wrong details' do
        expect{ post :create, params: { order: { detail_attributes:
                                                   {
                                                     first_name: nil,
                                                     last_name: nil,
                                                     city: order_detail.city,
                                                     phone: order_detail.phone,
                                                     street: order_detail.street,
                                                     house: order_detail.house
                                                   } } } }.to change(Order, :count).by(0)
      end
    end
  end
end
