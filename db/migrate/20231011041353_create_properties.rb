class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :property_type, null: false, foreign_key: true
      t.references :property_address, null: false, foreign_key: true
      t.string :operation, null: false 
      t.integer :price
      t.integer :maintenance
      t.integer :area
      t.text :description
      t.integer :bedrooms, default: 0
      t.integer :bathrooms, default: 0
      t.boolean :pets_allowed, default: false
      t.string :photo_url, array: true, default:[]
      t.boolean :active, default: true, null:false
      t.timestamps
    end
  end
end
