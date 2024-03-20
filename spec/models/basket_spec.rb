require 'rails_helper'

RSpec.describe Basket, type: :model do
  it { should have_many(:products).dependent(:destroy) }
  it { should belong_to(:user) }

  describe 'manipulate products in basket' do
    let(:product) { create(:product) }
    let(:basket) { create(:basket) }
    let(:products) { create_list(:product, 3) }
    it 'can put product in basket' do
      expect{ basket.put_product(product) }.to change{ BasketProduct.count }.by 1
    end
    it 'can increment product count in basket' do
      expect{ basket.put_product(product) }.to change{ BasketProduct.count }.by 1

      basket.put_product(product)
      expect(BasketProduct.count).to eq 1
      expect(basket.products.first.count).to eq 2
    end
    it 'can put a few product in basket' do
      expect{ products.each { |prod| basket.put_product(prod) } }.to change{ BasketProduct.count }.by 3

      basket_products = []
      BasketProduct.all.each { |basket_prod| basket_products<<basket_prod.product }
      expect(products).to match_array basket_products
    end
    it 'can decrease product count in basket' do
      3.times{ basket.put_product(product) }

      expect(basket.products.first.count).to eq 3
      basket.put_product_out(product)
      expect(basket.products.first.count).to eq 2
    end
    it 'can purge product after decrease if count <= 1' do
      basket.put_product(product)

      expect(basket.products.first.count).to eq 1
      expect{ basket.put_product_out(product) }.to change{ BasketProduct.count }.by -1
    end
    it 'can purge product in basket'do
      3.times{ basket.put_product(product) }

      expect(basket.products.first.count).to eq 3
      expect{ basket.purge_product(product) }.to change{ BasketProduct.count }.by -1
    end
  end
end
