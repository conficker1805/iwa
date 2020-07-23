module Users
  class SessionsController < Devise::SessionsController
    def new
      super
    end

    def create
      self.resource = warden.authenticate!(auth_options)

      if resource.has_role? :teacher
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        sign_out resource
        redirect_to new_user_session_path, alert: t('flash_message.student.unauthorized')
      end
    end

    protected

    def after_sign_in_path_for(resource)
      users_path
    end
  end
end
