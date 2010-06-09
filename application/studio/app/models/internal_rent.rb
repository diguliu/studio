class InternalRent < ActiveRecord::Base
  validates_presence_of :start, :duration

  belongs_to :agenda
  belongs_to :equip
  
end
