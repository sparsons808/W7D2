class SessionsController < ApplicationController
    before_action :ensure_logged_in, only: [:destroy]
    before_action :ensure_logged_out, only: [:new, :creates]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Worng email or password']
            render :new
        end
    end

    def destroy
        logout!
        flash[:success] = ['Logged out']
        redirect_to new_session_url
    end
end