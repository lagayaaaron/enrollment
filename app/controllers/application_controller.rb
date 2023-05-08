class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
            format.json { render nothing: true, status: :not_found }
            format.html { redirect_to main_app.root_url, notice: exception.message, status: :not_found }
            format.js   { render nothing: true, status: :not_found }
        end
    end

    def after_sign_in_path_for(resource)
        stored_location_for(resource) ||
            if resource.is_a?(User) && resource.can_publish?
            publisher_url
            else
            super
        end
    end
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :course_id, :year, :sem, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :course_id, :year, :sem, :avatar])
    end
end
