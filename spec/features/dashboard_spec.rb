require 'rails_helper'
require 'capybara/rails'

feature 'dashboard' do
  before :each do
    @user = create_user
  end

  scenario 'can create new rant' do
    login(@user)

    fill_in 'rant_title', with: 'robots'
    fill_in 'rant_rant', with: 'this won\'t hurt more than a pinch, so just pour a drink, let\'s talk it over?'
    click_on 'RANT'

    expect(page).to have_content('Your rant has been posted!')

    expect(page).to have_content('pinch')
    expect(page).to have_content('this won\'t hurt more than a pinch, so just pour a drink, let\'s talk it over?')
    expect(page).to have_content('Latest Rants')
  end

  scenario 'can\'t create empty rant' do
    login(@user)

    click_on 'RANT'

    expect(page).to have_content('all rant fields are required')
  end

  scenario 'can see other user\'s rants' do
    @other_user = create_other_user
    rant = create_rant(@other_user.id)

    login(@user)

    expect(page).to have_content(rant.rant)
    expect(page).to have_content(@other_user.first_name)

    within '.rant-wrapper:nth-child(2)' do
      expect(page).to_not have_link('Delete')
    end
  end
end