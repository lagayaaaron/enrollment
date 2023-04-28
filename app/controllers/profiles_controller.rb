# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController

    def edit
        @profile = current_user.profile
    end

    def update
        @profile = current_user.profile
        if @profile.update(profile_params)
        redirect_to profile_path, notice: "Profile updated successfully."
        else
        render :edit
        end
    end

    private

    def profile_params
        params.require(:profile).permit(:name, :email, :phone)
    end
end