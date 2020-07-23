module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'participation'

    def create
      super do
        resource.add_role(:user)
      end
    end
  end
end
