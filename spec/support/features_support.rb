module FeatureHelpers

  def login(user)
    visit root_path
    click_link 'Login'
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    click_button 'LOGIN'
    expect(page).to have_content("#{user.first_name} #{user.last_name}")
  end

end