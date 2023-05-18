class SubjectsController < ApplicationController
    load_and_authorize_resource
    before_action :set_subject, only: [:show, :edit, :update, :destroy]
  
    def index
      @subjects = Subject.all
  
      filter_subjects(params[:major], params[:year], params[:semester]) if params[:major].present? || params[:year].present? || params[:semester].present?
    end
  
    def show
    end
  
    def new
      @subject = Subject.new
    end
  
    def create
      @subject = Subject.new(subject_params)
  
      if @subject.save
        redirect_to @subject, notice: 'Subject was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @subject.update(subject_params)
        redirect_to @subject, notice: 'Subject was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @subject.destroy
      redirect_to subjects_url, notice: 'Subject was successfully destroyed.'
    end
  
    private
  
    def set_subject
      @subject = Subject.find(params[:id])
    end
  
    def filter_subjects(major, year, semester)
      @subjects = @subjects.where(subject_type: major) if major.present?
      @subjects = @subjects.where(year: year) if year.present?
      @subjects = @subjects.where(semester: semester) if semester.present?
    end
  
    def subject_params
      params.require(:subject).permit(:name, :subject_type, :year, :semester, :course_id)
    end
  end
  