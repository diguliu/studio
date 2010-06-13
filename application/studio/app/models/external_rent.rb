class ExternalRent < ActiveRecord::Base
  validates_presence_of :start, :duration
  validates_inclusion_of :status, :in => %w(reserved confirmed done canceled)

  belongs_to :client
  belongs_to :equip
  has_one :event, :dependent => :destroy

  before_save :calculate_total_price, :set_status
  after_create :create_event

  def cancel
    self.status = "canceled"
    event.destroy
    save
  end

  protected

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

  def calculate_total_price
    puts "-- Calculating total price..."
    self.price = equip.external_price*duration
  end

  def create_event
    Event.create!(:start_at => start, :end_at => start+(duration-1).days, :external_rent_id => id, :name => equip.classification)
  end

end
