class LikesController < ApplicationController
    before_action :authenticate_user!
    def create
      review = Review.find(params[:review_id])
      like = Like.new(user: current_user, review: review)
      @product = Product.find(params[:product_id])
      if !can?(:like, review)
        redirect_to review, alert: "can't like your own review"
      elsif like.save
        flash[:success] = "Review Liked"
        redirect_to product_path(@product)
      else
        flash[:danger] = like.errors.full_messages.join(", ")
        redirect_to product_path(@product)
      end
    end

    def destroy
      like = current_user.likes.find(params[:id])
      @product = like.review.product
      if can? :destroy, like
        like.destroy
        flash[:success] = "Review unliked"
        redirect_to product_path(@product)
      else
        flash[:danger] = "Can't unlike it"
        redirect_to product_path(@product)
      end
    end
end