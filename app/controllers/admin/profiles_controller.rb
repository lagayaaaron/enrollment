class Admin::ProfilesController < ApplicationController
    before_action :set_profile

    def show
    end
    
    def edit
    end
    def update
        if @profile.update(profile_params)
            flash[:success] = "Profile updated successfully"
            redirect_to admin_profile_path
        else
            render :edit
        end
    end
    
    private
    
    def set_profile
        @profile = current_user.profile
    end

    def profile_params
        params.require(:profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end
    
    end