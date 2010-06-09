class Client < ActiveRecord::Base
  validates_presence_of :login, :password, :person_id
  validates_uniqueness_of  :login

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
