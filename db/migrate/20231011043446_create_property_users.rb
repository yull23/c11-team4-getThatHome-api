class CreatePropertyUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :property_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.boolean :favorite , false
      t.boolean :contacted , false

      t.timestamps
    end
  end
end
