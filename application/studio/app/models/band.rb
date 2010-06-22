class Band < ActiveRecord::Base
  validates_presence_of :login, :name, :password, :password_confirmation
  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_uniqueness_of  :login
  validates_confirmation_of :password

  has_and_belongs_to_many :people
  has_many :agendas

  acts_as_authentic
end
