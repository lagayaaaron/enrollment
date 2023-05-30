class Admin::Students::ProfilesController < ApplicationController
    load_and_authorize_resource :student, find_by: :public_uid
    load_and_authorize_resource :profile, through: :student, singleton: true

    def edit
        if @student.profile.nil?
            flash[:notice] = "Student profile not found."
            redirect_to admin_students_path
        end
    end

    def update
        if @profile.update(profile_params)
            redirect_to admin_students_path, notice: "Profile updated successfully."
        else
            render :edit
        end
    end

    private

    def profile_params
        params.require(:profile).permit(:name, :email, :phone, :address, :birthdate)
    end
end