class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.string :password_digest
      t.string :token
      t.references :role, null: false, foreign_key: true
      
      t.timestamps
    end
    add_index :users, :token, unique: true
  end
end
