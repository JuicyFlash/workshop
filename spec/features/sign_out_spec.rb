require 'rails_helper'

feature 'User can sign out' do

  given(:user) { create(:user) }

  scenario 'Registered user tries to sign out' do
    sign_in(user)
    visit(root_path)
    click_on 'Account'
    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
