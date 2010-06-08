class Service < ActiveRecord::Base
  validates_presence_of :name, :price
  has_many :agendas 
end
