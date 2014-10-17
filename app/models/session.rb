class Session
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :username, :password

  validates :username, :password, presence: true
  validate 'user_found?'

  def initialize(params = {})
    @username = params[:username]
    @password = params[:password]
  end

  def user_found?
    user = User.find_by(username: username)
    unless user && user.authenticate(password) || username == '' || password == ''
      errors.add(:base, 'Username or password is incorrect')
    end
  end

  def user_id
    User.find_by(username: username).id
  end
end
