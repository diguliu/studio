class Client < ActiveRecord::Base
  validates_presence_of :login, :password, :password_confirmation, :person_id
  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_uniqueness_of  :login
  validates_confirmation_of :password

  has_many :external_rents
  has_many :equips, :through => :external_rents


  def add_equip(equip, start, duration)
    external_rent = ExternalRent.create!(:start => start, :duration => duration, :client => self, :equip => equip, :status => "reserved", :price => 0)
  end

  def remove_equip(equip)
    internal_rents.delete_if {|internal_rent| internal_rent.equip == equip}
    self.save
  end

end
