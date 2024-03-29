require 'rails_helper'

RSpec.describe Basket, type: :model do
  it { should have_many(:basket_products).dependent(:destroy) }
  it { should have_many(:products) }

  describe 'basket_products methods' do
    let!(:basket) { create(:basket) }
    let!(:product) { create(:product) }
    let!(:basket_product) { create(:basket_product, basket: basket, product: product, count: 5) }

    it 'can check product' do
      expect(basket.product_exist_in_basket?(product)).to eq true
    end
    it 'can calculate products count' do
      create_list(:basket_product, 4, basket: basket, count: 2)
      expect(basket.products_count).to eq 13
    end
  end
end
