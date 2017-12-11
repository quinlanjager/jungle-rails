require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "After creation" do
    before :each do
      @category = Category.create!
      @pants = Product.create!(name: "Pants", description: "Nice pants", price: 100, quantity: 10, category: @category)
      @shirt = Product.create!(name: "shirt", description: "Nice shirt", price: 100, quantity: 10, category: @category)
      @cart = [[@pants, {quantity: 1}], [@shirt, {quantity: 2}]]

      # create order and line items
      @order = Order.new(
        email: "test@test.com",
        total_cents: 120000,
        stripe_charge_id: 1,
        user_id: @user ? @user.id : nil
      )
      @cart.each do |product, details|
          quantity = details[:quantity]
          @order.line_items.new(
            product: product,
            quantity: quantity,
            item_price: product.price,
            total_price: product.price * quantity
          )
      end
    end

    it "should reduce product quantity if order is placed" do
      @order.save!
      expect(@pants.reload.quantity).to eql(9)
      expect(@shirt.reload.quantity).to eql(8)
    end

    it "should not deduct product quantity if the order is not valid" do
      @order.stripe_charge_id = nil
      @order.save
      expect(@pants.reload.quantity).to eql(10)
      expect(@shirt.reload.quantity).to eql(10)
    end

    it "should not deduct product quantity from products not in the order" do
      @shoes = Product.create!(name: "Shoes", description: "Nice shoes", price: 220, quantity: 10, category: @category)
      @order.save!
      expect(@shoes.reload.quantity).to eql(10)
    end

  end
end
