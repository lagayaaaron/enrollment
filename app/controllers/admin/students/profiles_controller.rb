class Admin::Students::ProfilesController < ApplicationController
    # before_action :set_student
    # authorize_resource
    
    load_and_authorize_resource :student, find_by: :public_uid
    load_and_authorize_resource :profile, through: :student, singleton: true
    # before_action :set_student

    def edit
        if @student.profile.nil?
            flash[:notice] = "Student profile not found."
            redirect_to admin_students_path
        # else   
        #     @profile = @student.profile
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

    def set_student
        @student = Student.find(params[:student_id])
    end

    def profile_params
        params.require(:profile).permit(:name, :email, :phone, :address, :birthdate)
    end
end