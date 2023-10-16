class User < ApplicationRecord
  has_secure_password
  has_secure_token
  belongs_to :role

  def invalidate_token
    update(token: nil)
  end
  
end
