class PropertyAddress < ApplicationRecord
  has_many :property, dependent: :destroy

  # validations
  validates :name, :latitude, :longitude, presence: true
end
