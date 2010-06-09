class Member < ActiveRecord::Base
  validates_presence_of :person_id
  has_and_belongs_to_many :bands
end
