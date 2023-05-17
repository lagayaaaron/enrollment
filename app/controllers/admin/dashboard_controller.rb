class Admin::DashboardController < DashboardController
    before_action :authenticate_user!
    before_action :authorize_admin
    skip_authorization_check

    def index
        @students = Student.count
        @instructors = Instructor.count
        @courses = Course.count
    end



    private
        def authorize_admin
            redirect_to root_path unless current_user.is_administrator?
        end
end #end of class