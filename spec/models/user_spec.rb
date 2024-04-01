require 'rails_helper'


RSpec.describe User, type: :model do

  it { should have_one(:basket).dependent(:destroy) }
  it { should have_many(:orders) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe 'validation user email'  do
    let(:user) { create(:user) }

    it 'cant create wrong email' do
      expect( User.count).to eq 0
      expect{ create(:user, email:"incorrectemail") }.to raise_error(ActiveRecord::RecordInvalid)
      expect( User.count).to eq 0
    end

    it 'cant update email to wrong email' do
      old_user_email = user.email
      user.email = "incorrectemail"
      expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(old_user_email).to eq User.first.email
    end
  end
end
