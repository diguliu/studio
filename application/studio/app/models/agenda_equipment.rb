class AgendaEquipment < ActiveRecord::Base
  validates_presence_of :duration, :time
end
