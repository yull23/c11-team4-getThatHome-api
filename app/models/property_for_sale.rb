class PropertyForSale < ApplicationRecord
  belongs_to :property
  has_one :user_property, dependent: :destroy
  
  # validations
  validates :price, numericality: { greater_than: 0 }, presence: true
end
