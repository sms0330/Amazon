class ContactController < ApplicationController
    def index
    end

    def create
        @name = params[:name]
        @email = params[:email]
        @message = params[:message]
    end
end