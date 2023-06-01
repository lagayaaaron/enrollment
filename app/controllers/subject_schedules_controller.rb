class SubjectSchedulesController < ApplicationController
    before_action :set_subject_schedule, only: [:show, :edit, :update, :destroy]
    # before_action :load_instructor_and_subject
    authorize_resource

    def index
        @subject_schedules = SubjectSchedule.all
        end

    def show
    end

    def new
    @subject_schedule = SubjectSchedule.new
    @instructors = Instructor.all
    @subjects = Subject.all
    end

    def create
    @subject_schedule = SubjectSchedule.new(subject_schedule_params)

    if @subject_schedule.save
        redirect_to @subject_schedule, notice: 'Subject schedule was successfully created.'
    else
        @instructors = Instructor.all
        @subjects = Subject.all
        render :new
    end
    end

    def edit
    @instructors = Instructor.all
    @subjects = Subject.all
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
    @subject_schedule = SubjectSchedule.find(params[:id])
    end

    def subject_schedule_params
    params.require(:subject_schedule).permit(:subject_id, :instructor_id, :start_time, :end_time, :day_of_week, :location)
    end
end
