class SessionsController < ApplicationController
    def new #to be called up for sign in form
    end

    def create
        @user = User.find_by_email params[:email] #email is unique so find by email for a user if it exists

        if @user && @user.authenticate(params[:password]) #check if the user exists and then authenticate that user 
            session[:user_id] = @user.id
            redirect_to root_path, notice: 'Logged in'
        else
            flash[:alert] = 'wrong email or password'
            render :new
        end

    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: 'Logged out'
    end
end