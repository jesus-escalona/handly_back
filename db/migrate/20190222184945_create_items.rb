class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :client, foreign_key: true
      t.string :picture
      t.string :item_type
      t.decimal :weight

      t.timestamps
    end
  end
end
