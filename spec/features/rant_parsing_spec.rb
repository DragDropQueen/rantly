require 'rails_helper'
require 'capybara/rails'

feature 'rants' do
  before :each do
    @user = create_user
    @other_user = create_other_user
  end

  scenario 'mentions' do
    skip
    @rant = Rant.create({title: 'rant', rant: "i scraped my knees while i was praying. @#{@other_user.username} and found a demon in my safest haven. seems like, its getting hard to believe in anything, than just to get lost in all my selfish thoughts. i wanna know what it'd be like to find perfection in my pride to see nothing in the light.", user: @user})

    sleep(5)

    login(@other_user)

    expect(page).to have_content('Mentioned')
    within '.mentioned-div' do
      expect(page).to have_content(@rant.rant)
    end
  end
end