class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_product, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    
    
    def index
        # @products = Product.all.order(created_at: :desc)
        if params[:tag]
            @tag = Tag.find_or_initialize_by(name: params[:tag])
            @products = @tag.products.all.order('updated_at DESC')
        else
            @products = Product.all.order(created_at: :desc) 
        end 
    end
    
    def new
        @product = Product.new
    end
    
    def create
        @product = Product.new product_params
        @product.user = current_user
        if @product.save
            ProductMailer.new_product(@product).deliver_later
            redirect_to product_path(@product.id)
        else
            render :new
        end
    end
    
    def show
        @review = Review.new
        @reviews = @product.reviews.order(created_at: :desc)
        @favourite = Favourite.find_by(product_id: @product, user_id: current_user) 
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
        params.require(:product).permit(:title,:description,:price, :tag_names)
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not authorized! please try again' unless can?(:crud, @product)
    end
    
end
