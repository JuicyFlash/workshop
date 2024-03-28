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
    let!(:user) { create(:user) }
    let!(:basket) { create(:basket, user: user) }
    let!(:basket_product) { create(:basket_product, basket: basket, product: product) }

    before do
      login(user)
    end
    it 'call Basket#put_product after call put_product_path' do
      expect_any_instance_of(Basket).to receive(:put_product)
      patch :put_in_basket, params: { id: product }, format: :turbo_stream
    end

    it 'call Basket#put_product_out after call put_out_product_path' do
      expect_any_instance_of(Basket).to receive(:put_product_out).and_call_original
      patch :put_out_basket, params: { id: product }, format: :turbo_stream
    end

    it 'call Basket#purge_product after call purge_product_path' do
      expect_any_instance_of(Basket).to receive(:purge_product).and_call_original
      patch :purge_from_basket, params: { id: product }, format: :turbo_stream
    end
  end
end
