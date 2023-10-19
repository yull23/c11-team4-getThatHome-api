class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :property_type, null: false, foreign_key: true
      t.references :property_address, null: false, foreign_key: true
      t.integer :bedrooms, default: 0
      t.integer :bathrooms, default: 0
      t.integer :area
      t.text :description
      t.string :photo_url, array: true, default:[]
      t.boolean :active, default: true, null:false
      t.integer :price
      t.integer :monthly_rent
      t.integer :maintenance
      t.boolean :pets_allowed, default: false
      t.string :operation, null: false 
      t.string :p_phone
      t.string :p_email

      
      t.timestamps
    end
  end
end
