class CreatePropertyAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :property_addresses do |t|
      t.string :name
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
