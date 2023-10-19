class CreatePropertyAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :property_addresses do |t|
      t.string :name, presence: true
      t.float :latitude, presence: false
      t.float :longitude, presence: false

      t.timestamps
    end
  end
end
