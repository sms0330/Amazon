class ReviewsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    def create
        @product = Product.find params[:product_id]
        @review = Review.new review_params
        @review.user = current_user
        @review.product = @product
        if @review.save
            ProductMailer.new_review(@review).deliver_now
            redirect_to product_path(@product), notice: 'Review Created'
        else
        @reviews = @product.reviews
        render 'products/show'
        end
    end

    def destroy
        @product = Product.find params[:product_id]
        @review = Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy
            redirect_to product_path(@product), notice: 'Review Deleted'
        else
            redirect_to root_path, alert: "Not authorized!"
        end
    end
    

    private
    def review_params
        params.require(:review).permit(:body,:rating)
    end
    
end
