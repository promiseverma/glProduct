class CreateOrderSessions < ActiveRecord::Migration
  def change
    create_table :order_sessions do |t|
      t.string :products_list
      t.string :token

      t.timestamps null: false
    end
  end
end
