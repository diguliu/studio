class Equip < ActiveRecord::Base
  validates_presence_of :external_price, :internal_price

  has_many :internal_rents
  has_many :agendas, :through => :internal_rents
  has_many :external_rents
  has_many :clients, :through => :external_rents
end
