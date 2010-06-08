class Client < ActiveRecord::Base
  has_one :person
  validates_presence_of :password
end
