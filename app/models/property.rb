class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :property_address
  has_one :property_for_sale, dependent: :destroy
  has_one :property_for_rent, dependent: :destroy
end
