class UserMailer < ApplicationMailer
  def order_receipt(user, order)
    @user = user
    @order = order
    @line_items = order.line_items

    # get product sum
    @product_sum = 0
    @line_items.each do |line_item|
      @product_sum += line_item.product.price
    end

    mail(to: @user.email, subject:"Your order receipt for Order ID: #{@order.id}")
  end
end
