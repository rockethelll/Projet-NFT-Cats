class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, default: 1
      t.integer :order_id
      t.integer :cart_id
      t.belongs_to :item, index: true

      t.timestamps
    end
  end
end
