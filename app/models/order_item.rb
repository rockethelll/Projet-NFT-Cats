class OrderItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :cart, optional: true
  belongs_to :item

  # validates :item_id, uniqueness: { scope: :order_id, message: "ne peut être qu'une seule fois dans une commande" }
  # validates :item_id, uniqueness: { scope: :cart_id, message: "ne peut être qu'une seule fois dans une commande" }
  validates :quantity, numericality: { in: 1..99 }
  validate :attached_cart_or_order

  def total_price
    quantity * item.price
  end

  private

  def attached_cart_or_order
    return unless cart.nil? && order.nil?

    errors.add(:cart_id, 'has to be present if order_id is not present')
    errors.add(:order_id, 'has to be present if cart_id is not present')
  end
end
