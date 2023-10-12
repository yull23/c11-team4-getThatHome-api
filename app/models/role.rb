class Role < ApplicationRecord
  has_many :user, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true
end
