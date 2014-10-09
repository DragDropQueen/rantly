require 'rails_helper'
require 'capybara/rails'

feature 'rant show' do
  before :each do
    @user = create_user
    @rant = create_rant(@user)
    login(@user)
  end

  scenario 'can view a rant' do
    click_on @rant.rant

    expect(page).to have_content(@rant.rant)
    expect(page).to have_content(@rant.title)
    expect(page).to have_selector('.rant-show')
  end
end
