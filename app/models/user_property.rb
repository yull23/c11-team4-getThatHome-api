class UserProperty < ApplicationRecord
  belongs_to :user
  belongs_to :propertyable, polymorphic: true
end
