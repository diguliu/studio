class Band < ActiveRecord::Base
  validates_presence_of :login, :name, :password
  validates_uniqueness_of  :login

  has_and_belongs_to_many :members
  has_many :agendas
end
