require 'rails_helper'

RSpec.describe BasketService do

  describe 'unauthenticated user' do
    let(:basket) { create(:basket, user:nil) }

    it 'take new basket ' do
      expect(Basket.count).to eq 0
      bs = BasketService.new({ basket_id: nil }, nil)

      expect(Basket.count).to eq 1
      expect(bs.basket.id).to eq Basket.first.id
    end
    it 'find basket' do
      bs = BasketService.new({ basket_id: basket.id }, nil)

      expect(bs.basket.id).to eq basket.id
    end
  end

  describe 'unauthenticated user' do
    let!(:user) { create(:user) }
    let(:basket) { create(:basket, user: nil) }

    it 'take new basket for new user' do
      expect(Basket.count).to eq 0
      BasketService.new({ basket_id: nil }, user)

      expect(Basket.count).to eq 1
    end
    it 'find basket for authenticated user' do
      bs = BasketService.new({ basket_id: nil }, user)
      user.reload

      expect(bs.basket.id).to eq user.basket.id
    end
    it 'copy products from unauthenticated user basket to user basket' do
      @basket_service = BasketService.new({ basket_id: basket.id }, nil)
      @basket_products = create_list(:basket_product, 3, basket: @basket_service.basket)

      @user_basket_service = BasketService.new({ basket_id: basket.id }, user)
      expect(@basket_products.to_a).to eq @user_basket_service.basket.products.to_a
    end
  end
end
