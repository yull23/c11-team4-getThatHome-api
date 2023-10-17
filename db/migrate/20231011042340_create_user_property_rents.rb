class CreateUserPropertyRents < ActiveRecord::Migration[7.0]
  def change
    create_table :property_for_rents do |t|
      t.references :property, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
