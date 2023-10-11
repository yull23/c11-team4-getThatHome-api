class CreatePropertYsers < ActiveRecord::Migration[7.0]
  def change
    create_table :property_user do |t|
      t.references :user_id, null: false, foreign_key: true
      t.references :property_id, null: false, foreign_key: true
      t.boolean :favorite
      t.boolean :contacted

      t.timestamps
    end
  end
end
