class AdmissionsController < ApplicationController
    load_and_authorize_resource

    def index
        @admissions = current_user.admissions
    end

    def new
        @subject_schedules = SubjectSchedule.includes(:instructor, :subject).all
        @admission = Admission.new
    end

    def create
        @subject_schedules = SubjectSchedule.includes(:instructor, :subject).all
        subject_schedule_ids = params[:admission][:subject_schedule_ids]

        respond_to do |format|
            subject_schedule_ids.each do |subject_schedule_id|
                @admission = Admission.new(subject_schedule_id: subject_schedule_id, student_id: current_user.id)
                unless @admission.save
                    format.html { render :new, status: :unprocessable_entity }
                    format.json { render json: @admission.errors, status: :unprocessable_entity }
                end
            end
            format.html { redirect_to admissions_path, notice: "Enrollment was successfully created." }
            format.json { render :index, status: :created, location: @admission }
        end
    end

    private

    def admission_params
        params.require(:admission).permit(:student_id, :subject_schedule_id, :subject_schedule_ids)
    end
end

