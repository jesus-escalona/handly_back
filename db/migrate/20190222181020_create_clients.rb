class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :email_verified
      t.string :phone_number
      t.string :avatar

      t.timestamps
    end
  end
end
