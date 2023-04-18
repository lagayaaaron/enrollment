class DashboardController < ApplicationController
    before_action :authenticate_user!
    # before_action :check_role

    private

    def check_role
        if current_user.is_administrator? && !request.path.starts_with?('/admin')
            redirect_to admin_dashboard_path
        elsif current_user.is_student? && !request.path.starts_with?('/student')
            redirect_to student_dashboard_path
        elsif current_user.is_instructor? && !request.path.starts_with?('/instructor')
            redirect_to instructor_dashboard_path
        end
    end
    
end