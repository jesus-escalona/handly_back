class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :email_verified
      t.string :phone_number
      t.string :avatar, default: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/84c20033850498.56ba69ac290ea.png'

      t.timestamps
    end
  end
end
