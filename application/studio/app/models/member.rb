class Member < ActiveRecord::Base
  has_one :person
  belongs_to :band
end
