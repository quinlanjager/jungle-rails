class ReviewsController < ApplicationController
  def create
    product_id = params[:product_id]

    @review = Review.new review_params
    @review.user_id = @user.id || nil
    @review.product_id = product_id

    # check if valid before saving
    if not @review.valid?
      redirect_to Product.find(product_id), alert: @review.errors.full_messages[0]
      return
    end

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
