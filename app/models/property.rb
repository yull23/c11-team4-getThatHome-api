class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :property_address
  has_many :property_user, dependent: :destroy
  has_one :property_for_sale, dependent: :destroy
  has_one :property_for_rent, dependent: :destroy

  # validations
  validates :area, :description, presence: true
  validates :active, inclusion: [true, false]
  validates :bedrooms, :bathrooms, :area, numericality: { greater_than_or_equal_to: 0 }


end
