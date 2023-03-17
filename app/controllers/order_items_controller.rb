class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    item = Item.find(params[:item_id])
    current_cart = current_user.cart

    if current_cart.items.include?(item)
      @order_item = current_cart.order_items.find_by(item_id: item)
      @order_item.quantity += 1
    else
      @order_item = OrderItem.new
      @order_item.cart = current_cart
      @order_item.item = item
    end

    @order_item.save
    flash[:success] = 'Image ajoutée au panier'
  end

  def add_quantity
    @order_item = OrderItem.find(params[:id])
    @order_item.quantity += 1
    if @order_item.save
      flash[:success] = 'Quantité augmentée !'
    else
      flash[:alert] = 'Impossible de commander plus de 99 exemplaires'
    end
    redirect_to cart_path
  end

  def reduce_quantity
    @order_item = OrderItem.find(params[:id])
    @order_item.quantity -= 1
    if @order_item.save
      flash[:success] = 'Quantité diminuée !'
    else
      @order_item.destroy
      flash[:success] = 'Produit retiré du panier !'
    end
    redirect_to cart_path
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to cart_path
  end
end
