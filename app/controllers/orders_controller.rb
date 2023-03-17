class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end
  def create
    @cart = current_user.cart
    @order = Order.new(user: current_user, status: "pending")
    @order.save
    @cart.order_items.each do |order_item|
      OrderItem.create!(order: @order, item: order_item.item, quantity: order_item.quantity)
    end
    @cart.destroy
    @cart = Cart.new(user: current_user)
    @cart.save
    redirect_to checkout_create_path(total: 50)
  end

  def show
    @order = Order.find_by(user: current_user)
  end
end
