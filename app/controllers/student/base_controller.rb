class Student::BaseController < ApplicationController

    # Authenticate user as student
    before_action :authenticate_student!

    private

    # Check if user is authenticated as student
    def authenticate_student!
        authenticate_user!
        redirect_to root_path unless current_user.is_student?
    end

    def current_student
        @current_student ||= current_user if current_user.is_student?
    end
end
