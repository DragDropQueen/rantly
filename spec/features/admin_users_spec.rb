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

    within '.header' do
      click_on 'Users'
    end
  end

  scenario 'can see a list of users' do
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

  scenario 'can disable a user' do
    within('.row:nth-child(2)') do
      click_on 'Disable'
    end

    expect(page).to have_content('✓')
    expect(page).to have_content('Enable')

    within('.header') do
      click_on 'LOGOUT'
    end

    login(@other_user)

    expect(page).to have_content 'This account is disabled'

    login(@admin)

    visit admin_users_path

    within('.row:nth-child(2)') do
      click_on 'Enable'
    end

    expect(page).to_not have_content('✓')
    expect(page).to have_content('Disable')

    within('.header') do
      click_on 'LOGOUT'
    end

    login(@other_user)

    expect(page).to have_content('Latest Rants')
  end
end

