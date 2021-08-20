class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new user_params
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged In!"
      else
        render :new
      end
    end

    def dashboard
      if current_user.is_admin?
        @user_number = User.all.count
        @product_number = Product.all.count
        @review_number = Review.all.count
      else
        redirect_to root_path
      end
    end
    
    def show
      @user=User.find params[:id]
    end
  
    private
  
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      )
    end
  end