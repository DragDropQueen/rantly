require 'rails_helper'
require 'capybara/rails'

feature 'favoriting', js: true do
  before do
    @user = create_user
    @rant = create_rant(@user)
    create_other_rant(@user)

    @logged_in_user = create_other_user

    login(@logged_in_user)
  end

  scenario 'can favorite rants and have them sorted on user profiles', js: true do
    within('.rant-wrapper:nth-child(3)') do
      click_on 'Favorite'
      click_on @user.first_name
    end

    within('h3:nth-child(2)') do
      expect(page).to have_content(@rant.title)
    end
  end

  scenario 'can view favorited rants on the favorite tab', js: true do
    within('.rant-wrapper:nth-child(3)') do
      click_on 'Favorite'
    end

    within '.header' do
      click_on 'Favorites'
    end

    expect(page).to have_content 'Favorited Rants'
    expect(page).to have_content @rant.rant
  end

  scenario 'can unfavorite rants', js: true do
    within('.rant-wrapper:nth-child(3)') do
      click_on 'Favorite'
    end

    click_on 'Unfavorite'

    within '.header' do
      click_on 'Favorites'
    end

    expect(page).to have_content 'Favorited Rants'
    expect(page).to_not have_content @rant.rant
  end

  scenario 'can see the number of times a rant has been favorited', js: true do
    within('.rant-wrapper:nth-child(3)') do
      click_on 'Favorite'
    end

    expect(page).to have_content '❤ 1'

    click_on 'Unfavorite'

    expect(page).to have_content '❤ 0'
  end
end