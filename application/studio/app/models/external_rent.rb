class ExternalRent < ActiveRecord::Base
  validates_presence_of :start, :duration
  validates_inclusion_of :status, :in => %w(done canceled reserved)

  belongs_to :client
  belongs_to :equip

  before_save :calculate_total_price,:set_status

  protected

  def set_status
    puts "-- Setting status..."
    if((start <=> 3.day.ago) < 0)
      self.status = "reserved"
    else
      self.status = "done"
    end
  end

  def calculate_total_price
    puts "-- Calculating total price..."
    self.price = equip.external_price*duration
  end

end
