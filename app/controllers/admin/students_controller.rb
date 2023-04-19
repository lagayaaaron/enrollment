class Admin::StudentsController < ApplicationController
    # before_action :set_student, only: [:show, :edit, :update, :destroy]
    
    def index
        @students = Student.all
    end
    
    def new
        @user = User.new
        @student = @user.build_student
    end

    def create
        @user = User.new(user_params)
        @user.add_role(params[:user][:role])

        if @user.save
            @student = @user.create_student(student_params)
            flash[:success] = "Student created successfully"
            redirect_to admin_users_path
        else
            render :new
        end
    end

    def edit
        @student = Student.find(params[:id])
        @student_profile = @student.profile
    end

    def update
        @student = Student.find(params[:id])
        @student_profile = @student.profile
        
        if @student_profile.update(profile_params)
            flash[:success] = "Profile updated successfully"
            redirect_to admin_students_path
        else
            render :edit
        end
    end

    def show
    end

    def destroy
        @student.destroy
        flash[:success] = "Student deleted successfully"
        redirect_to admin_students_path
    end

    private

    def set_student
        @student = Student.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def profile_params
        params.require(:profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end

end