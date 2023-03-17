class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end