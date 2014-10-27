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
end
