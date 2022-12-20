class UsersController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_out, only: [:show]
    def new
        @users = User.new
        render :new
    end

    def show 
        @users = User.find_by(id: params[:id])
        render :show
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            login(@user)
            redirect_to user_url(@user)
        else 
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end



    def user_params
        params.require(:user).permit(:email, :password)
    end
end 