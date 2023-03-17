class CartsController < ApplicationController
  before_action :authenticate_user!, :my_cart?

  def show
    @cart = Cart.find(params[:id])
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    @cart = Cart.new
    @cart.user = current_user
    @cart.save
    redirect_to cart_path(@cart)
  end

  private

  def my_cart?
    return if current_user.cart == Cart.find(params[:id])

    redirect_back fallback_location: root_path
  end
end
