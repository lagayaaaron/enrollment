class CoursesController < ApplicationController
  load_and_authorize_resource
  # before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
  end

  def search
      @search = Course.search do
          with(:state, :published) if current_user.has_role? (:student)
          any do
              fulltext(params[:name], :fields => [:name])
          end
          with(:state, params[:state]) if params[:state].present?
          with(:code, params[:code]) if params[:code].present?
          order_by :code, :asc
          paginate :page => params[:page], :per_page => 4
      end 
      # search end
      @courses = @search.results
      render 'search'
  end
  # GET /courses/1 or /courses/1.json
  def show
    @versions = @course.versions
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    # authorize! :create, @course
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    # authorize! :update, @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def publish
    @course = Course.find(params[:id])
    @course.publish!
    redirect_to @course
  end

  def unpublish
    @course = Course.find(params[:id])
    @course.unpublish!
    redirect_to @course
  end

  def rollback
    @course = Course.find(params[:id])
    @version = @course.versions.find(params[:version])
    @course = @version.reify
    @course.save
    redirect_to course_path(@course)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:code, :name, :description)
    end
end
