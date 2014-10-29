require 'rails_helper'
require 'capybara/rails'

feature 'Admin Rants' do
  before do
    @admin = create_admin_user
    @user = create_user
    @other_rant = create_other_rant(@user)
    @rant = create_rant(@user)

    @other_user = create_other_user

    login(@admin)

    within '.header' do
      click_on 'Rants'
    end
  end

  scenario 'sees an ordered list of rants in the system' do
    expect(page).to have_content('Rants')
    expect(page).to have_content('Actions')

    within('.row:nth-child(2)') do
      expect(page).to have_content(@rant.title)
    end

    within('.row:nth-child(3)') do
      expect(page).to have_content(@other_rant.title)
    end
  end

  scenario 'can filter rants by date' do
    fill_in 'end_date', with: '2014-10-09'

    click_on 'Filter'

    expect(page).to_not have_content(@rant.title)
    expect(page).to_not have_content(@other_rant.title)
  end

  scenario 'can resolve spam rants' do
    @rant.destroy

    @rant = create_rant(@user, {spam: true})

    click_on 'Spam'

    expect(page).to have_content @rant.title

    click_on 'Not Spam'

    expect(page).to have_content("Rant #{@rant.title} has been marked as not spam.")

    within('.admin-table') do
      expect(page).to_not have_content(@rant.title)
    end

    click_on 'All'

    expect(page).to have_content @rant.title
  end

  scenario 'can delete spam rants' do
    @rant.destroy

    @rant = create_rant(@user, {spam: true})

    click_on 'Spam'

    expect(page).to have_content @rant.title

    click_on 'Delete'

    expect(page).to have_content("Rant #{@rant.title} has been deleted.")

    within('.admin-table') do
      expect(page).to_not have_content(@rant.title)
    end

    click_on 'All'

    expect(page).to_not have_content @rant.title
  end
end