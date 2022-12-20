class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:create, :new]
    before_action :require_logged_in, only: [:destroy]
    def new
        @user = User.new
        render :new
    end

    def create
        @user = user.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to new_session_url
        end
    end

    def destroy
        if logged_in?
            logout!
        end

        redirect_to new_session_url
    end


end