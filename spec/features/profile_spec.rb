require 'rails_helper'
require 'capybara/rails'

feature 'profile' do
  before :each do
    @user = create_user
    @other_user = create_other_user
    @rant = create_rant(@other_user)
    login(@user)
  end

  scenario 'can edit profile' do
    click_on @other_user.first_name

    expect(page).to have_content full_name(@other_user)
    expect(page).to have_link Follow
    expect(page).to have_content @other_user.bio
  end

  scenario 'can access profile from rant show' do
    click_on @rant.rant

    click_on @other_user.first_name

    expect(page).to have_content full_name(@other_user)
    expect(page).to have_link Follow
    expect(page).to have_content @other_user.bio
  end

  scenario "can view a user's rants on their profile" do
    click_on @rant.rant

    click_on @other_user.first_name

    expect(page).to have_content(@rant.title)
    expect(page).to have_content(@rant.rant)
    expect(page).to have_content('Favorite')
  end
end