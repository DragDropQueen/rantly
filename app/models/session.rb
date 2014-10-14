class Session
  attr_accessor :username_error, :password_error, :general_error

  def initialize(params)
    @params = params
  end

  def user
    @user || User.new
  end

  def authenticate
    find_user
    if @user && @user.authenticate(@params[:user][:password])
      true
    elsif @params[:user][:password] == ''
      set_password_error
      false
    else
      set_general_error
      false
    end
  end

  private

  def find_user
    set_username_error if @params[:user][:username] == ''
    @user = User.find_by(:username => @params[:user][:username])
  end

  def set_username_error
    @username_error = "can't be blank"
  end

  def set_password_error
    @password_error = "can't be blank"
  end

  def set_general_error
    @general_error = "Username or password is incorrect"
  end
end
