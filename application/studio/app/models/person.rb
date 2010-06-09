class Person < ActiveRecord::Base
  validates_presence_of :cpf, :name 
  validates_uniqueness_of  :cpf
  validates_inclusion_of :gender, :in => %w(male female)

  has_one :member
  has_one :client
end
