require 'rails_helper'

RSpec.describe ProductPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:not_logged_user) { nil }

  subject { described_class }

  permissions :put_in_basket? do
    it 'grants access if user logged in' do
      expect(subject).to permit(user, product)
    end
    it 'not grants access if user not logged in' do
      expect(subject).to_not permit(not_logged_user, product)
    end
  end
  permissions :put_out_basket? do
    it 'grants access if user logged in' do
      expect(subject).to permit(user, product)
    end
    it 'not grants access if user not logged in' do
      expect(subject).to_not permit(not_logged_user, product)
    end
  end
  permissions :purge_from_basket? do
    it 'grants access if user logged in' do
      expect(subject).to permit(user, product)
    end
    it 'not grants access if user not logged in' do
      expect(subject).to_not permit(not_logged_user, product)
    end
  end
end
