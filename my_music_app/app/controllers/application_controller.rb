class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :log_in_user!
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login(user)
        session[session_token] = user.reset_session_token!
    end

    def logged_in?
        !!current_user
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in
    end

    def logout!
        current_user.reset_session_token! if logged_in?
        session[session_token] = nil
        @current_user = nil
    end

    def ensure_logged_out
        redirect_to users_url if logged_in?
    end

    def log_in_user!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end


end
