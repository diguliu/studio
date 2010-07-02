class Person < ActiveRecord::Base
  validates_presence_of :cpf, :name
  validates_uniqueness_of  :cpf
  validates_inclusion_of :gender, :in => %w(male female)
  validates_format_of :email, :with => /(^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})|^$)/i, :message => "Invalid email"  


  has_and_belongs_to_many :bands
end
