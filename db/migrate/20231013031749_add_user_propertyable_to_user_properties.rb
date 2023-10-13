class AddUserPropertyableToUserProperties < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_properties, :userPropertyable, polymorphic: true, null: false
  end
end
