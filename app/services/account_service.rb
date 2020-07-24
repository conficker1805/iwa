class AccountService
  attr_reader :headers

  def initialize(headers = {})
    @headers = headers
  end

  # Authenticate with token
  def auth!
    @user ||= find_user_with_role!
  end

  # Authenticate with email & password
  def self.find(params)
    cred = params[:credentials]
    user = User.with_role(:student).find_by(email: cred[:email])
    raise Error::InvalidCredential if !user || !user.valid_password?(cred[:password])
    user
  end

  private

  def find_user_with_role!
    user = User.with_role(:student).find_by(id: decoded_auth_token.try(:[], :user_id)&.to_i)
    user || raise(Error::InvalidCredential)
  end

  def auth_header
    raise Error::InvalidCredential, I18n.t('err.credential.missing_token') if @headers['Authorization'].empty?
    @headers['Authorization']
  end

  def decoded_auth_token
    @decoded_auth_token ||= begin
      body = JWT.decode(auth_header, Rails.application.credentials.secret_key_base)
      HashWithIndifferentAccess.new body[0]
    end
  rescue JWT::DecodeError => e
    raise Error::InvalidCredential
  end
end
