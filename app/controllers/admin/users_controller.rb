class Admin::UsersController < ApplicationController
    load_and_authorize_resource
    before_action :load_course
    def index
        @users = User.where.not(:public_uid => current_user.public_uid)
    end

    def new
        @user = User.new
        @generated_password = Devise.friendly_token.first(12)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Successfully created User." 
            redirect_to root_path
        else
            render :action => 'new'
        end
    end

    def edit
    end

    def update
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
        
        if @user.update(user_params)
            flash[:notice] = "Successfully updated User."
            redirect_to root_path
        else
            render :action => 'edit'
        end
    end

    def destroy
        if @user.destroy
            flash[:notice] = "Successfully deleted User."
            redirect_to root_path
        end
    end 

    private

    def user_params
        params.require(:user).permit(:username, :email, :type, :password, :password_confirmation, :course_id, :year, :sem, :public_uid)
    end
    def load_course
        @courses = Course.all
    end
end