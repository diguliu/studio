class ClientEquipment < ActiveRecord::Base
  validates_presence_of :duration, :time, :status
end
