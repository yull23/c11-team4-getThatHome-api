class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :property_address
  belongs_to :user
  has_many :property_users, dependent: :destroy

  # validations
  validates :area, :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :maintenance, presence: true, numericality: { only_integer: true }
  validates :active, :pets_allowed, inclusion: [true, false]
  validates :bedrooms, :bathrooms, :area, numericality: { greater_than_or_equal_to: 0 }
end
