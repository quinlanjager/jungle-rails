class Review < ActiveRecord::Base
  validates :product_id, :rating, presence: true
  belongs_to :product
  belongs_to :user
end
