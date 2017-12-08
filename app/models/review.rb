class Review < ActiveRecord::Base
  validates :product_id, :rating, presence: true
  validates :rating, numericality: {only_integer: true, less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }
  belongs_to :product
  belongs_to :user
end
