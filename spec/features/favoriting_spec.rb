require 'rails_helper'
require 'capybara/rails'

feature 'favoriting' do
  scenario 'can favorite rants' do
    @user = create_user
    @rant = create_rant(@user)
    create_other_rant(@user)

    @logged_in_user = create_other_user

    login(@logged_in_user)

    within('.rant-wrapper:nth-child(3)') do
      click_on 'Favorite'
      click_on @user.first_name
    end

    within('h3:first-child') do
      expect(page).to have_content(@rant.title)
    end
  end
end