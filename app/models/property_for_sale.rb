class PropertyForSale < ApplicationRecord
  belongs_to :property_id
  has_one :property_user, dependent: :destroy
  # validations
  validates :price, numericality: { greater_than: 0 }, presence: true
end
