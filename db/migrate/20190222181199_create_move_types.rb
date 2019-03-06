class CreateMoveTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :move_types do |t|
      t.string :moving_type
      t.decimal :price_factor, precision: 3, scale: 2, default: 1
      t.string :icon
      t.integer :move_value
      t.integer :max_items
      t.timestamps
    end
  end
end
