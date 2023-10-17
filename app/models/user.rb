class User < ApplicationRecord
  has_secure_password
  has_secure_token
  belongs_to :role

  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 16 }
  # no es obligatorio tener un rol para el usuario optional: true
  belongs_to :role, optional: true
end
