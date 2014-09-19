require 'rails_helper'
require 'capybara/rails'

feature 'rant' do
  before :each do
    @user = create_user
    login(@user)
  end

  scenario 'can delete a rant' do
    @rant = create_rant(@user.id)

    visit '/dashboard'

    within('.dashboard-div') do
      click_link 'Delete'
    end

    expect(page).to have_content('rant deleted!')

    expect(page).to_not have_content(@rant.title)

    expect(page).to_not have_content('i just want to be better than, than your heads only')
  end
end