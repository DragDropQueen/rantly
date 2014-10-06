require 'rails_helper'
require 'capybara/rails'

feature 'interactions with other users' do
  before :each do
    @user = create_user
    @other_user = create_other_user
    @other_user_rant = create_other_rant(@other_user)
    login(@user)
  end

  scenario 'can follow another user' do
    click_on 'Follow'
    expect(page).to have_link('Unfollow')

    within '.header' do
      click_on 'Following'
    end
    expect(page).to have_content('Following')
    expect(page).to have_content(full_name(@other_user))
    expect(page).to have_link('Unfollow')
  end

  scenario 'can unfollow other users' do
    click_on 'Follow'
    click_on 'Unfollow'

    within '.header' do
      click_on 'Following'
    end
    expect(page).to_not have_link('Unfollow')
    expect(page).to_not have_content(full_name(@other_user))
  end
end
