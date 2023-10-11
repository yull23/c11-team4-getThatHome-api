class PropertyType < ApplicationRecord
  has_many :property, dependent: :destroy

  # Validations

  validates :name, presence: true, uniqueness: false
end
