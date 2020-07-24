module Api
  module V1
    class BaseController < ActionController::API
      include Error

      helper JsonLayoutHelper

      respond_to :json

      protected

      def authenticate_student!
        @current_user = AccountService.new(request.headers).auth!
      end

      def current_user
        @current_user
      end

      def id
        params.require(:id)
      end

      def page
        params.fetch(:page, 1)
      end
    end
  end
end
