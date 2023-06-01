class SubjectSchedulesController < ApplicationController
    
    before_action :load_instructor_and_subject
    load_and_authorize_resource


    def index
        @subject_schedules = SubjectSchedule.all
    end

    def show

    end

    def new
        @subject_schedule = SubjectSchedule.new
    end

    def create
        @subject_schedule = SubjectSchedule.new(subject_schedule_params)
        respond_to do |format|
            if @subject_schedule.save
            format.html { redirect_to subject_schedule_url(@subject_schedule), notice: "Schedula was successfully created." }
            format.json { render :show, status: :created, location: @course }
            else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @course.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        @instructors = Instructor.all
        @subjects = Subject.roots 
        @subsubjects = @subjects.flat_map(&:descendants).reject(&:root?)
    end

    def update
    if @subject_schedule.update(subject_schedule_params)
        redirect_to @subject_schedule, notice: 'Subject schedule was successfully updated.'
    else
        @instructors = Instructor.all
        @subjects = Subject.all
        render :edit
    end
    end

    def destroy
        @subject_schedule.destroy
        redirect_to subject_schedules_url, notice: 'Subject schedule was successfully destroyed.'
    end

    private

    def set_subject_schedule
        @subject_schedule = SubjectSchedule.find_by(params[:id])
    end
    def load_instructor_and_subject
        @instructors = Instructor.all
        @subjects = Subject.roots 
        @subsubjects = @subjects.flat_map(&:descendants).reject(&:root?)
    end
    def subject_schedule_params
        params.require(:subject_schedule).permit(:subject_id, :instructor_id, :start_time, :end_time, :day_of_week, :location)
    end
end
