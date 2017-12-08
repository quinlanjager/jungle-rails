class UserMailer < ApplicationMailer
  def order_receipt(user, order)
    @user = user
    @order = order
    @line_items = order.line_items

    mail(to: @user.email, subject:"Your order receipt for Order ID: #{@order.id}")
  end
end
