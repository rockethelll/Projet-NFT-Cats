class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show 
    @item = Item.find(params[:id])
  end
  def filter
    @items = Item.all
    @items_filtered = Item.where(rarity: params[:search])
    @items_filtered_by_title = Item.where(title: params[:search])
  end
end
