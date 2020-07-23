module Users
  class SessionsController < Devise::SessionsController
    def new
      super
    end

    protected

    def after_sign_in_path_for(resource)
      dashboard_index_path
    end
  end
end
