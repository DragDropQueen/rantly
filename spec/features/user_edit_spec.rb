require 'rails_helper'
require 'capybara/rails'

feature 'profile' do
  before :each do
    @user = create_user
    login(@user)
  end

  scenario 'can edit profile' do
    click_on full_name(@user)
    expect(find_field('user_first_name').value).to eq @user.first_name
    expect(find_field('user_last_name').value).to eq @user.last_name
    expect(page).to have_content @user.bio
    expect(find_field('user_email').value).to eq @user.email
    expect(has_checked_field?('user_frequency_daily')).to eq true

    fill_in 'user_password', with: @user.password

    click_on "Edit profile"

    expect(page).to have_content('Your profile has been updated!')
  end

  scenario 'gives edit validation errors' do
    click_on full_name(@user)

    fill_in 'user_email', with: ''

    click_on 'Edit profile'

    expect(page).to have_content('')
  end
end