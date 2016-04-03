class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :num_order
      t.string :customer
      t.string :color
      t.integer :amount
      t.integer :loss
      t.integer :plates
      t.float :fabric
      t.float :foam
      t.integer :total
      t.integer :is_factured, default: 2 # 1 = production, 0 = not procution 3 = wait

      t.timestamps null: false
    end
  end
end
