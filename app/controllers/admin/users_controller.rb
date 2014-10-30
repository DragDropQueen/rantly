class Admin::UsersController < Admin::AdminController
  def index
    if params[:order] == 'true'
      @users = User.where(admin: false).sort_by{ |user|
        user.rants.count
      }.reverse
    else
      @users = User.where(admin: false).order(:created_at).reverse
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.active
      @user.update(active: false)
      redirect_to admin_users_path, notice: "User #{@user.email} has been disabled."
    else
      @user.update(active: true)
      redirect_to admin_users_path, notice: "User #{@user.email} has been enabled."
    end
  end
end