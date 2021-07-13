class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    before_action :find_product, only: [:show, :edit, :update, :destroy]
    
    def index
        @products = Product.all.order(created_at: :desc) 
    end
    
    def new
        @product = Product.new
    end
    
    def create
        @product = Product.new product_params
        @product.user = current_user
        if @product.save
            redirect_to product_path(@product.id)
        else
            render :new
        end
    end
    
    def show
        @review = Review.new
        @reviews = @product.reviews.order(created_at: :desc) 
    end
    
    def destroy
        @product.destroy
        redirect_to products_path
    end

    def edit
        
    end

    def update
        if @product.update product_params
            redirect_to product_path(@product)
        else
            render :edit
        end
    end
    
    
    
    private
    def find_product
        @product = Product.find params[:id]
    end

    def product_params
        params.require(:product).permit(:title,:description,:price)
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not authorized! please try again' unless can?(:crud, @product)
    end
    
end
