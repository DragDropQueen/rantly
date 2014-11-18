require 'rails_helper'
require 'capybara/rails'

feature 'profile' do
  before :each do
    @user = create_user
    @other_user = create_other_user
    @rant = create_rant(@other_user)
    login(@user)
  end

  scenario 'can view profile' do
    click_on @other_user.first_name

    expect(page).to have_content full_name(@other_user)
    expect(page).to have_link Follow
    expect(page).to have_content @other_user.bio
  end

  scenario 'can access profile from rant show' do
    visit rant_path(@rant)

    click_on @other_user.first_name

    expect(page).to have_content full_name(@other_user)
    expect(page).to have_link Follow
    expect(page).to have_content @other_user.bio
  end

  scenario "can view a user's rants on their profile" do
    visit rant_path(@rant)

    click_on @other_user.first_name

    expect(page).to have_content(@rant.title)
    expect(page).to have_content(@rant.rant)
    expect(page).to have_content('Favorite')
  end

  scenario 'can comment on a user\'s profile' do
    visit rant_path(@rant)

    click_on @other_user.first_name

    fill_in 'comment_body', with: 'comment rawr'

    click_on 'RANT BACK'

    expect(page).to have_content('comment rawr')
  end
end