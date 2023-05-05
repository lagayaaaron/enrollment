class ProfilesController < ApplicationController
    load_and_authorize_resource
    before_action :set_profile, only: %i[show edit update destroy]
    def new
        @profile = current_user.build_profile if current_user.profile.nil?
    end

    def create
        @profile = current_user.build_profile if current_user.profile.nil?
        if @profile.update(profile_params)
            flash[:notice] = "Current Profile created successfully"
            redirect_to profile_path
        else
            render 'new'
        end
    end

    def show
        if @profile.nil?
            flash[:notice] = "User profile not found."
            redirect_to root_path
        else   
            @profile = @current_user.profile
        end
    end
    
    def edit
    end

    def update
        if @profile.update(profile_params)
            flash[:success] = "User updated successfully"
            redirect_to profile_path
        else
            render :edit
        end
    end
    private

    def set_profile
        @profile = current_user.profile
    end

    def profile_params
        params.require(:profile).permit(:name, :gender, :birthdate, :contact_number, :address)
    end
end