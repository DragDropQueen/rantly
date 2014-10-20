require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do
  before :each do
    @request.env['HTTP_REFERER'] = 'http://test.host/dashboard'

    @user = create_user
    @rant = create_rant(@user)
    session[:user_id] = @user.id
  end
end
