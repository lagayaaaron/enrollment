class Admin::Users::ProfilesController < ApplicationController
    load_and_authorize_resource :user, find_by: :public_uid
    load_and_authorize_resource :profile, through: :user, singleton: true

    def edit
        if @user.profile.nil?
            flash[:notice] = "Student profile not found."
            redirect_to admin_dashboard_path
        end
    end

    def update
        if @profile.update(profile_params)
            redirect_to admin_dashboard_path, notice: "Profile updated successfully."
        else
            render :edit
        end
    end

    private

    def profile_params
        params.require(:profile).permit(:name, :email, :phone, :address, :birthdate)
    end
end