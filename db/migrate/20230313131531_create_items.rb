class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.float :price
      t.integer :rarity
      t.string :image_url

      t.timestamps
    end
  end
end
