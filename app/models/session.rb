class Session
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :email, :password

  validates :email, :password, presence: true
  validate 'user_found?', 'user_active?'

  def initialize(params = {})
    @email = params[:email]
    @password = params[:password]
  end

  def user_found?
    user = User.find_by(email: email)
    unless user && user.authenticate(password) || email == '' || password == ''
      errors.add(:base, 'Email or password is incorrect')
    end
  end

  def user_active?
    user = User.find_by(email: email)
    unless password == '' || !user || !user.authenticate(password) || user.active
      errors.add(:base, 'This account is disabled')
    end
  end

  def user_id
    User.find_by(email: email).id
  end

  def user
    User.find_by(email: email)
  end
end
