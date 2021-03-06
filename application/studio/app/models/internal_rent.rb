class InternalRent < ActiveRecord::Base
  validates_presence_of :start, :duration
  validate :inside_time

  belongs_to :agenda
  belongs_to :equip

  after_save :update_agenda

  private

  def inside_time
    if(start)
      errors.add(:start, "The equipment rent can't start before the service.") if start < agenda.start
    end
    if(duration)
      errors.add(:duration, "The equipmente rent can't last after the service end.") if start+duration > agenda.start+agenda.duration
    end
  end

  def update_agenda
    agenda.save
  end
  
end
