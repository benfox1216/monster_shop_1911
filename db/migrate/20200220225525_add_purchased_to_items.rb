class AddPurchasedToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :purchased, :integer, default: 0
  end
end
