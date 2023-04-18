class DashboardController < ApplicationController
    before_action :authenticate_user!
    # before_action :check_role

    private
        def check_role

            if current_user.has_role? :admin
                redirect_to admin_root_path

            elsif current_user.has_role? :student
                redirect_to student_root_path

            elsif current_user.has_role? :instructor
                redirect_to instructor_dashboard_path
        end
    end
end