class CreateMovers < ActiveRecord::Migration[5.2]
  def change
    create_table :movers do |t|
      t.string :company_name
      t.string :admin_name
      t.text :address
      t.boolean :verified
      t.string :logo
      t.boolean :insured
      t.decimal :bid_factor, precision: 3, scale: 2, default: 1

      t.timestamps
    end
  end
end
