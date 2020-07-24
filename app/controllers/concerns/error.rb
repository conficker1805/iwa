module Error
  extend ActiveSupport::Concern

  class InvalidCredential < StandardError; end

  included do
    rescue_from ActionController::ParameterMissing, with: :formatted_error
    rescue_from Error::InvalidCredential, with: :formatted_error
  end

  private

  def formatted_error(e)
    @message = I18n.t("exception.#{e.class.to_s.underscore}")
    @details = e.message

    render 'api/v1/error'
  end
end
