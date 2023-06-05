class Admin::InstructorsController < ApplicationController
    load_and_authorize_resource :instructor, find_by: :public_uid

    def index
        @instructors = Instructor.all
    end

    def new
        @instructor = Instructor.new
        @generated_password = Devise.friendly_token.first(12)
    end

    def create
        @instructor = Instructor.new(instructor_params)
        if @instructor.save
            @instructor_profile = @instructor.create_profile(profile_params)
            flash[:notice] = "Instructor created successfully"
            redirect_to admin_instructors_path
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @instructor.update(instructor_params)
            redirect_to admin_users_path, notice: "Instructor Account updated successfully."
        else
            render :edit
        end
    end

    def destroy
        if @instructor.destroy
            flash[:notice] = "Student deleted successfully"
            redirect_to admin_users_path
        else
            flash[:notice] = "Error"
            render :edit
        end
    end

    private

    def instructor_params
        params.require(:instructor).permit(:username, :email, :password, :password_confirmation, :course_id, :year, :sem, :public_uid)
    end

    def profile_params
        params.require(:instructor).require(:instructor_profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end

    
end