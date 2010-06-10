class Agenda < ActiveRecord::Base

  validates_presence_of :start, :duration, :room, :status, :band_id, :service_id
  validates_inclusion_of :status, :in => %w(reserved done canceled)

  belongs_to :band
  belongs_to :service
  has_many :internal_rents
  has_many :equips, :through => :internal_rents


  def add_equip(equip, start, duration)
    internal_rents << InternalRent.new(:start => start, :duration => duration, :agenda => self, :equip => equip)
    self.save
  end

  def remove_equip(equip)
    internal_rents.delete_if {|internal_rent| internal_rent.equip == equip}
    self.save
  end

  before_save :calculate_total_price, :set_status

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
    if((start <=> 3.day.ago) > 0)
      self.status = "reserved"
    else
      self.status = "done"
    end
  end

end
