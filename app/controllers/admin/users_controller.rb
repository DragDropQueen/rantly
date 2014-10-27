class Admin::UsersController < Admin::AdminController
  def index
    @users = User.where(admin: false).sort_by{|user| user.rants.count}.reverse if params[:order] == 'true'

    @users = User.where(admin: false).reverse unless params[:order] == 'true'
  end
end