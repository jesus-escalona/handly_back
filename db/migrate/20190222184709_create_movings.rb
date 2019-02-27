class CreateMovings < ActiveRecord::Migration[5.2]
  def change
    create_table :movings do |t|
      t.references :client, foreign_key: true
      t.references :mover, foreign_key: true
      t.decimal :origin_lat, precision: 14, scale: 8
      t.decimal :origin_lng, precision: 14, scale: 8
      t.string :origin_administrative
      t.string :origin_address
      t.decimal :destination_lat, precision: 14, scale: 8
      t.decimal :destination_lng, precision: 14, scale: 8
      t.string :destination_administrative
      t.string :destination_address
      t.datetime :moving_time
      t.decimal :estimate, precision: 16, scale: 2
      t.decimal :final_price, precision: 16, scale: 2
      t.integer :moving_rating
      t.text :moving_review
      t.decimal :distance, precision: 16, scale: 2
      t.string :moving_type

      t.timestamps
    end
  end
end
