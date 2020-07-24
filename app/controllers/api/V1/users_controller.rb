module Api
  module V1
    class UsersController < BaseController
      def sign_in
        @user = AccountService.find(credential_params)
      end

      private

      def credential_params
        params.require(:credentials).require([:email, :password])
        params.permit(credentials: [:email, :password])
      end
    end
  end
end
