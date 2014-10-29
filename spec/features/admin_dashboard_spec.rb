require 'rails_helper'
require 'capybara/rails'

feature 'Admin Dashboard' do
  before do
    @admin = create_admin_user
    @user = create_user
    @rant = create_rant(@user)
    create_other_rant(@user)

    @other_user = create_other_user

    login(@admin)
  end

  scenario 'is redirected properly on log in' do
    expect(page).to have_content 'Statistics'

    within('.header') do
      expect(page).to have_link('Rants')
    end
  end
end