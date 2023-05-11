class ApplicationController < ActionController::Base
    protect_from_forgery
    check_authorization unless: :devise_controller?
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :user_for_paper_trail
    
    rescue_from CanCan::AccessDenied do |exception|
        if current_user.nil?
            session[:next] = request.fullpath
            redirect_to login_url, alert: 'You have to log in to continue.'
        else
            respond_to do |format|
            format.json { render nothing: true, status: :not_found }
            format.html { redirect_to main_app.root_url, alert: exception.message }
            format.js   { render nothing: true, status: :not_found }
            end
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

    def user_for_paper_trail
        user_signed_in? ? current_user.username : 'Public user'  # or whatever
    end
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :course_id, :year, :sem, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password, :course_id, :year, :sem, :avatar])
    end
end
