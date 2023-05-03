class Admin::StudentsController < ApplicationController
    before_action :set_student, only: %i[show edit update destroy]
    
    def index
        if params[:query]
            @search = Student.search do
                fulltext params[:query]
            end
            @students = @search.results
        else
            @students = Student.includes(:course, :profile).all
        end        
    end
    def search
        @search = Student.search do
            any do
                fulltext(params[:email], :fields => [:email])
                fulltext(params[:course], :fields => [:course_name])
                fulltext(params[:name], :fields => [:profile_name])
            end
            with(:profile_gender, params[:gender]) if params[:gender].present?
            with(:course_code, params[:code]) if params[:code].present?
            order_by :course_code, :asc
            paginate :page => params[:page], :per_page => 4
        end 
        # search end
        @students = @search.results
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
            flash[:notice] = "Student created successfully"
            redirect_to admin_students_path
        else
            render :new
        end
    end

    def show
    end

    def destroy
        if @student.destroy
            flash[:notice] = "Student deleted successfully"
            redirect_to admin_dashboard_path
        else
            flash[:notice] = "Error"
            redirect_to admin_dashboard_path
        end
    end

    private

    def set_student
        @student = Student.find(params[:id])
        @student_profile = @student.profile
    end

    def user_params
        params.require(:student).permit(:email, :password, :password_confirmation, :course_id, :year, :sem)
    end

    def profile_params
        params.require(:student).require(:student_profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end

end