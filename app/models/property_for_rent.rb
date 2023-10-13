class PropertyForRent < ApplicationRecord
  belongs_to :property
  has_one :user_property, as: :userPropertyable, dependent: :destroy

  # Validations

  validates :monthly_rent, :maintenance, numericality: { greater_than: 0 }, presence: true
  validates :pets_allowed, inclusion: [true, false]
end
