class Event < ActiveRecord::Base
  validates_presence_of :start_at, :end_at
  has_event_calendar
end
