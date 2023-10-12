class PropertyUser < ApplicationRecord
  belongs_to :user_id
  belongs_to :property_id
end
