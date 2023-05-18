class SubjectsController < ApplicationController
    load_and_authorize_resource
    # before_action :set_subject, only: [:show, :edit, :update, :destroy]
    
    def index
        @parent_subjects = Subject.roots
    end
    
    def show
        @parent_subject = Subject.find(params[:id])
        @child_subjects = @parent_subject.children
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

    def new_child
        @parent_subject = Subject.find(params[:id])
        @child_subject = @parent_subject.children.new
    end

    def create_child
        @parent_subject = Subject.find(params[:id])
        @child_subject = @parent_subject.children.new(subject_params)

        if @child_subject.save
            redirect_to subject_path(@parent_subject), notice: 'Child subject was successfully created.'
        else
            render :new_child
        end
    end

    private
    
    def set_subject
        @subject = Subject.find(params[:id])
    end
    
    def subject_params
        params.require(:subject).permit(:name, :code, :subject_type, :year, :semester, :course_id)
    end
end
