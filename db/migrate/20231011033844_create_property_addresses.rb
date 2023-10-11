class CreatePropertyAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :property_addresses do |t|
      t.string :name
      t.bigint :latitude
      t.bigint :longitude

      t.timestamps
    end
  end
end
