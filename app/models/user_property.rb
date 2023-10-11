class UserProperty < ApplicationRecord
  belongs_to :user_id
  belongs_to :property_for_rent_id
  belongs_to :property_for_sale_id
end
