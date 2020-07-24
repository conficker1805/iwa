module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      render body: nil
    end
  end
end
