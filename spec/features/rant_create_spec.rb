require 'rails_helper'
require 'capybara/rails'

feature 'dashboard' do
  before :each do
    @user = create_user
  end

  scenario 'can create new rant' do
    login(@user)

    fill_in 'rant_title', with: 'robots'
    fill_in 'rant_rant', with: 'this won\'t hurt more than a pinch, so just pour a drink, let\'s talk it over? I\'m back after all these years, don\'t be afraid my dear. Now I\'m older.'
    click_on 'RANT'

    expect(page).to have_content('Your rant has been posted!')

    expect(page).to have_content('pinch')
    expect(page).to have_content('this won\'t hurt more than a pinch, so just pour a drink, let\'s talk it over?')
    expect(page).to have_content('Latest Rants')
  end

  scenario 'can\'t create empty rant' do
    login(@user)

    click_on 'RANT'

    expect(page).to have_content('A rant about: can\'t be blank')
    expect(page).to have_content('Rant: can\'t be blank')
  end

  scenario 'rant fields validate length' do
    login(@user)

    fill_in 'rant_title', with: 'living in a city of sleepless people who all know the limit and won\'t go too far outside the lines cause they\'re out of their minds'
    fill_in 'rant_rant', with: 'i wanna get out'

    click_on 'RANT'

    expect(page).to have_content('A rant about: is too long (maximum is 50 characters)')
    expect(page).to have_content('Rant: is too short (minimum is 140 characters)')
  end

  scenario 'can see other user\'s rants' do
    @other_user = create_other_user
    rant = create_rant(@other_user)

    login(@user)

    expect(page).to have_content(rant.rant)
    expect(page).to have_content(@other_user.first_name)

    within '.rant-wrapper:nth-child(2)' do
      expect(page).to_not have_link('Delete')
    end
  end

  scenario 'renders rants with markdown properly' do
    rant = create_rant(@user, {rant: "the truth is worse than *anything* i could bring myself to do to you. I walk this house in your shoes, i know it's strange. it's a strange way of saying i know i'm supposed to love you. i'm supposed to love you."})

    login(@user)

    expect(page).to have_content("the truth is worse than anything i could bring myself to do to you. I walk this house in your shoes, i know it's strange. it's a strange way of saying i know i'm supposed to love you. i'm supposed to love you.")
  end
end