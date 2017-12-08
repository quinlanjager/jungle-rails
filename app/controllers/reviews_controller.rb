class ReviewsController < ApplicationController
  def create
    @review = Review.new review_params
    @review.user_id = @user || nil
    @review.product_id = params[:product_id]
    @review.save
    redirect_to Product.find(@review.product_id), notice: "Review posted succesfully!"
  end

  def edit
  end

  def destroy
  end

  private
    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
