class Agenda < ActiveRecord::Base

  validates_presence_of :start, :duration, :room, :status, :band_id, :service_id
  validates_inclusion_of :status, :in => %w(reserved confirmed done canceled)

  belongs_to :band
  belongs_to :service
  has_many :internal_rents
  has_many :equips, :through => :internal_rents
  has_one :event, :dependent => :destroy


  def add_equip(equip, start, duration)
    InternalRent.create!(:start => start, :duration => duration, :agenda => self, :equip => equip)
    save
  end

  def remove_equip(equip)
    ir = InternalRent.find(:first, :conditions => {:equip_id => equip.id})
    ir.destroy
    save
  end

  def cancel
    self.status = "canceled"
    event.destroy
    save
  end

  before_save :calculate_total_price, :set_status
  after_create :create_event

  protected

  def calculate_total_price
    puts "-- Calculating total price..."
    equips_price = 0
    internal_rents.each do |internal_rent|
      equips_price += internal_rent.equip.internal_price*internal_rent.duration
    end
    self.total_price = service.price*duration + equips_price
  end

  def set_status
    puts "-- Setting status..."
    if status != "canceled"
      if start > Time.now+2.days
        self.status = "reserved"
      elsif Time.now < start && start < Time.now+2.days
        self.status = "confirmed"
      else
        self.status = "done"
      end
    end
  end

  def create_event
    Event.create!(:start_at => start, :end_at => start+duration.hours, :agenda_id => id, :name => band.name)
  end

end
