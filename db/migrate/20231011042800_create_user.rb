class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :user do |t|
      t.string :name
      t.string :phone
      t.references :role_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end