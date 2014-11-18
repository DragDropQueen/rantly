require 'rails_helper'
require 'capybara/rails'

feature 'rant show' do
  before :each do
    @user = create_user
    @rant = create_rant(@user)
    login(@user)

    visit rant_path(@rant)
  end

  scenario 'can view a rant' do
    expect(page).to have_content(@rant.rant)
    expect(page).to have_content(@rant.title)
    expect(page).to have_selector('.rant-show')
  end

  scenario 'can comment on a rant' do
    comment = "i'm a comment!"

    fill_in 'comment_body', with: comment

    click_on 'RANT BACK'

    expect(page).to have_content(comment)
  end

  scenario 'can tweet a link to a rant', js: true do
    click_on 'b'
  end

  scenario 'can mark a rant as spam' do
    click_on 'Spam'

    click_on 'Rant.ly'

    expect(page).to_not have_content(@rant.rant)
  end
end
