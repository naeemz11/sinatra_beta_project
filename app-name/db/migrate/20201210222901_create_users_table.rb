class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.string :item
      t.string :item_price
      t.integer :total 
    end 
  end
end
