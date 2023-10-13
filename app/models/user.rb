class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 16 }
#no es obligatorio tener un rol para el usuario optional: true
  belongs_to :role , optional: true
end
