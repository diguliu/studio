class Band < ActiveRecord::Base
  has_many :members
  validates_presence_of :name, :password
end
