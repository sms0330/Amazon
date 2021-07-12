class ApplicationController < ActionController::Base
    def authenticate_user! #redirect if the user is signed in or not
        redirect_to new_sessions_path, notice: 'Please sign in' unless user_signed_in?
    end
    
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end

    helper_method :current_user #this is used by any method that you need access from both the controllers and views

    def user_signed_in?
        current_user.present? #return true or false 
    end
    helper_method :user_signed_in?

end