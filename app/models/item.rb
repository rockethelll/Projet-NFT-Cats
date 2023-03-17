class Item < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :carts, through: :order_items
  belongs_to :category

  validates :title, presence: true,
                    uniqueness: true,
                    length: { in: 3..30 }
  # format: { with: %r{\A[\w -/]\z} }

  validates :description, presence: true,
                          length: { in: 5..500 }

  validates :price, presence: true,
                    numericality: { greater_than: 0 }

  validates :rarity, presence: true,
                     numericality: { in: 0..4 }

  validates :image_url, presence: true
end
