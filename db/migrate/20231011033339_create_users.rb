class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email, null: false
      t.string :password_digest
      t.string :token
      t.integer :role_id, null: false
      
      t.timestamps
    end
    add_index :users, :token, unique: true
    add_foreign_key :users, :roles
  end
end
