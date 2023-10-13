class UserProperty < ApplicationRecord
  belongs_to :user
  #belongs_to :userprorpertyable, polymorphic: true
  belongs_to :userPropertyable, polymorphic: true
end


