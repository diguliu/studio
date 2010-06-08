class Equipment < ActiveRecord::Base
  validates_presence_of :external_price, :internal_price
end
