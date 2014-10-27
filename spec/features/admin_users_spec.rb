require 'rails_helper'
require 'capybara/rails'

feature 'Admin Rsers' do
  before do
    @admin = create_admin_user
    @user = create_user
    @rant = create_rant(@user)
    create_other_rant(@user)

    @other_user = create_other_user

    login(@admin)
  end

  scenario 'can see a list of users' do
    within '.header' do
      click_on 'Users'
    end

    expect(page).to have_content('Users')
    expect(page).to have_content('Disabled')

    within('.row:nth-child(2)') do
      expect(page).to have_content(full_name(@other_user))
      expect(page).to have_content(0)
    end

    within('.row:nth-child(3)') do
      expect(page).to have_content(full_name(@user))
      expect(page).to have_content(2)
    end
  end

  scenario 'can sort the list of users' do
    within '.header' do
      click_on 'Users'
    end

    click_on 'Number of Rants'

    within('.row:nth-child(2)') do
      expect(page).to have_content(full_name(@user))
      expect(page).to have_content(2)
    end

    within('.row:nth-child(3)') do
      expect(page).to have_content(full_name(@other_user))
      expect(page).to have_content(0)
    end

    click_on 'Number of Rants'

    within('.row:nth-child(2)') do
      expect(page).to have_content(full_name(@other_user))
      expect(page).to have_content(0)
    end

    within('.row:nth-child(3)') do
      expect(page).to have_content(full_name(@user))
      expect(page).to have_content(2)
    end
  end
end

