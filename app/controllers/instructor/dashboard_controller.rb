class Instructor::DashboardController < DashboardController
    before_action :authenticate_user!
    before_action :authorize_instructor
    
    def index
    end



    private
        def authorize_instructor
            redirect_to root_path unless current_user.is_instructor?
        end

end #end of class