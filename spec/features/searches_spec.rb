require 'rails_helper'
require 'capybara/rails'

feature 'searching' do
  before do
    @user = create_user
    @rant = create_rant(@user)

    @user.__elasticsearch__.index_document
    @rant.__elasticsearch__.index_document
  end

  scenario 'can search by last name' do
    login(@user)

    within '.header' do
      click_link 'Search'
    end

    sleep(2)

    fill_in 'search', with: @user.last_name

    click_button 'SEARCH'

    expect(page).to have_content(@rant.rant)
    expect(page).to have_content(@user.first_name)
    expect(page).to have_link('Delete')
  end
end