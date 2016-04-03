class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :input_output
      t.decimal :red_fabric
      t.decimal :white_fabric
      t.decimal :black_fabric
      t.decimal :foam

      t.timestamps null: false
    end
    execute "INSERT INTO stocks VALUES (1, 1, 40, 60, 50, 600,
      '2015-03-03 10:00', '2015-03-03 10:00')"
  end
end
