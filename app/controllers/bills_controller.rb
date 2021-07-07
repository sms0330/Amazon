class BillsController < ApplicationController
    def index
        
    end
    
    def calculate
        @amount = params[:amount].to_f
        @tax = params[:tax].to_f
        @tip = params[:tip].to_f
        @number_of_people = params[:number_of_people].to_i
        @total = (@amount*(@tax/100+1)*(@tip/100+1)/@number_of_people).round(2)
        render :new
    end
    
end