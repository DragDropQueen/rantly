require 'rails_helper'
require 'capybara/rails'

feature 'Admin Rants' do
  before do
    @admin = create_admin_user
    @user = create_user
    @rant = create_rant(@user)
    @other_rant = create_other_rant(@user)

    @other_user = create_other_user

    login(@admin)
  end

  scenario 'sees an ordered list of rants in the system' do
    within '.header' do
      click_on 'Rants'
    end

    expect(page).to have_content('Rants')
    expect(page).to have_content('Actions')

    within('.row:nth-child(2)') do
      expect(page).to have_content(@rant.title)
    end

    within('.row:nth-child(3)') do
      expect(page).to have_content(@other_rant.title)
    end
  end
end