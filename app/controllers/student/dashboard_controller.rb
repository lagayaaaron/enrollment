class Student::DashboardController < DashboardController
    before_action :authenticate_user!
    before_action :authorize_student
    
    def index
    end



    private
        def authorize_student
            redirect_to root_path unless current_user.is_student?
        end

end #end of class