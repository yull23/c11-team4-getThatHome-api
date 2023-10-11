class PropertyForRent < ApplicationRecord
  belongs_to :property_id
  has_one :user_property, dependent: :destroy

  # Validations

  validates :monthly_rent, :maintenance, numericality: { greater_than: 0 }, presence: true
  validates :pets_allowed, inclusion: [true, false]
end
