require 'rails_helper'
require 'capybara/rails'

feature 'homepage' do
  scenario 'there is a homepage' do
    visit "/"
    expect(page).to have_content('Rantly')
    expect(page).to have_content('Jeff Taggart, avid Ranter')
  end

  scenario 'can register' do
    visit '/'
    click_button 'JOIN'
    fill_in 'user_username', with: 'monochrome'
    fill_in 'user_password', with: 'schnee337'
    fill_in 'user_first_name', with: 'Blake'
    fill_in 'user_last_name', with: 'Belladona'
    fill_in 'user_bio', with: 'former member of the White Fang'
    choose 'user_frequency_daily'
    click_button 'REGISTER'
    expect(page).to have_content 'You have registered successfully!'

    expect(page).to_not have_content('Welcome back! Please consider registering to begin your ranting!')
  end

  scenario 'can login' do
    user = create_user
    login(user)
  end

  scenario 'registration errors' do
    user = create_user
    visit '/'
    click_button 'JOIN'
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: 'short'

    click_button 'REGISTER'
    expect(page).to have_content 'Bio can\'t be blank'
    expect(page).to have_content 'Username is taken'
    expect(page).to have_content '8 char minimum'
  end

  scenario 'gives empty login errors' do
    visit '/'
    click_link 'Login'

    click_button 'LOGIN'

    expect(page).to have_content('Username can\'t be blank')
    expect(page).to have_content('Password can\'t be blank')
  end

  scenario 'gives improper login errors' do
    user = create_user

    visit '/'

    click_link 'Login'

    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: 'wrong password'

    click_button 'LOGIN'

    expect(page).to have_content('Username or password is incorrect')
  end

  scenario 'gives never-registered message' do
    visit '/'

    expect(page).to_not have_content('Welcome back! Please consider registering to begin your ranting!')

    visit '/'

    expect(page).to have_content('Welcome back! Please consider registering to begin your ranting!')
  end
end