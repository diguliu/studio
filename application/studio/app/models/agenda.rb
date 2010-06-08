class Agenda < ActiveRecord::Base
  validates_presence_of :time, :duration, :room, :status
end
