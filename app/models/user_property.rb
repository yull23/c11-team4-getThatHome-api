class UserProperty < ApplicationRecord
  belongs_to :user
  belongs_to :userprorpertyable, polymorphic: true
  # belongs_to :property_for_rent_id
  # belongs_to :property_for_sale_id
end
