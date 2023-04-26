class Instructor::ProfilesController < ApplicationController

    def show
        @profile = current_user.profile
    end
    
    def edit
        @profile = current_user.profile 
    
    end
    def update
        @profile = current_user.profile
            if @profile.update(profile_params)
            flash[:success] = "Profile updated successfully"
            redirect_to instructor_profile_path
        else
            render :edit
        end
    end
    
    private
    
    def profile_params
        params.require(:profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end
    
end