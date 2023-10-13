class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 16 }
  
#Varios usuarios tienen el mismo rol
  belongs_to :role
  # has_many :role 

end
