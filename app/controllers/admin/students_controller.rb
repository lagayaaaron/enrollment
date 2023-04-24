class Admin::StudentsController < ApplicationController
    before_action :set_student, only: %i[ show edit update destroy ]
    
    def index
        @students = Student.all
        
    end
    def search
        @search = Student.search do
            any do
                fulltext(params[:query], :fields => [:student_name])
            end
            order_by :id, :asc
            paginate :page => params[:page], :per_page => 5
        end 
        # search end
        @students = @search.results
        render 'search'
    end
    def new
        @user = User.new
        @student = @user.build_student
    end

    def create
        @user = User.new(user_params)
        @user.add_role(:student)

        if @user.save
            @student = @user.student
            @profile = @student.build_profile(profile_params)
            flash[:success] = "Student created successfully"
            redirect_to admin_students_path(@student)
        else
            render :new
        end
    end

    def edit
        @student_profile = @student.profile
    end

    def update
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
        raise "qwe"
        @student.destroy!
        flash[:success] = "Student deleted successfully"
        redirect_to admin_dashboard_path
    end

    private

    def set_student
        @student = Student.find(params[:id])
        @student_profile = @student.profile
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def profile_params
        params.require(:profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end

end