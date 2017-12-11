class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  after_create :lower_product_quantity

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  private
    def lower_product_quantity
      self.line_items.each do |line_item|
        line_item.product.quantity -= line_item.quantity
        line_item.product.save
      end
    end
end
