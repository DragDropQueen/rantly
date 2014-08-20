require 'rails_helper'
require 'capybara/rails'

feature 'homepage' do
  scenario 'there is a homepage' do
    visit "/"
    expect(page).to have_content('Rantly')
    expect(page).to have_content('Jeff Taggart, avid Ranter')
  end

  scenario 'can view registration page' do
    visit '/'
    click_button 'JOIN'
    fill_in 'Username', with: 'monochrome'
  end
end