class CreateUserProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :user_properties do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property_for_rent, null: false, foreign_key: true
      t.references :property_for_sale, null: false, foreign_key: true

      t.timestamps
    end
  end
end
