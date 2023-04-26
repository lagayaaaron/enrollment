class Admin::StudentsController < ApplicationController
    before_action :set_student, only: %i[show edit update destroy]
    
    def index
        @students = Student.all
        
    end
    def search
        @search = Profile.search do
            # fulltext params[:name] do
            #     fields(:student_name)
            # end
            #with(:name).starting_with(params[:name]) if params[:name].present?
            any do
                fulltext(params[:name], :fields => [:name])
                fulltext(params[:email], :fields => [:email])
            end
            order_by :id, :asc
            paginate :page => params[:page], :per_page => 6
        end 
        # search end
        @students = @search.results
        # raise @students.inspect
        render 'search'
    end

    def new
        @student = Student.new
        @courses = Course.all
    end

    def create
        @student = Student.new(user_params)
        @courses = Course.all

        if @student.save
            @student_profile = @student.create_profile(profile_params)
            flash[:success] = "Student created successfully"
            redirect_to admin_students_path
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
        params.require(:student).permit(:email, :password, :password_confirmation, :course_id)
    end

    def profile_params
        params.require(:student).require(:student_profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end

end