module Api
  module V1
    class BaseController < ActionController::API
      include Error

      helper JsonLayoutHelper

      respond_to :json

      def current_user
        @current_user
      end
    end
  end
end
