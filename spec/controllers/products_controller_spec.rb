require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    let(:products) { create_list(:product, 5) }
    before { get :index }

    it 'populates an array of all products' do
      expect(assigns(:products)).to match_array(products)
    end
    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'manipulate the products in the basket' do
    let!(:product) { create(:product) }
    let!(:basket) { create(:basket) }
    let!(:user) { create(:user) }

    before { login(user) }
    it 'call Basket#put_product after call put_product_path' do
      expect_any_instance_of(Basket).to receive(:put_product)
      patch :put_in_basket, params: { id: product }
    end
    it 'call Basket#put_product_out after call put_out_product_path' do
      expect_any_instance_of(Basket).to receive(:put_product_out)
      patch :put_out_basket, params: { id: product }
    end
    it 'call Basket#purge_product after call purge_product_path' do
      expect_any_instance_of(Basket).to receive(:purge_product)
      patch :purge_from_basket, params: { id: product }
    end
  end
end
