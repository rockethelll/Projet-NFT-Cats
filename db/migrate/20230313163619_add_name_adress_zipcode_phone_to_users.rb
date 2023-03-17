class AddNameAdressZipcodePhoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :adress, :string
    add_column :users, :zipcode, :string
    add_column :users, :phone, :string
  end
end
