class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :property do |t|
      t.references :property_type, null: false, foreign_key: true
      t.references :property_address, null: false, foreign_key: true
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :area
      t.text :description
      t.string :photo_url
      t.boolean :active

      t.timestamps
    end
  end
end
