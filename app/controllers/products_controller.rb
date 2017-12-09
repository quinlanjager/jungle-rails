class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews
    @review = Review.new
    @avg_rating = average_total_rating(@reviews)
  end

  private
    def average_total_rating(reviews)
      sum = 0

      reviews.each do |review|
        sum += review.rating
      end
      reviews.length > 0 ? (sum / reviews.length).round : 0
    end
end
