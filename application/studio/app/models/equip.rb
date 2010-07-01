class Equip < ActiveRecord::Base
  validates_presence_of :external_price, :internal_price, :classification

  has_many :internal_rents
  has_many :agendas, :through => :internal_rents
  has_many :external_rents
  has_many :clients, :through => :external_rents

  def self.xml_equips
    xml_file = ""
    xml = Builder::XmlMarkup.new(:target => xml_file, :indent => 2)
    xml.equipments do
      Equip.all.each do |equipment|
        xml.equipment do
          xml.model(equipment.model)
          xml.description(equipment.description)
          xml.classification(equipment.classification)
          xml.internal_price(equipment.internal_price)
          xml.external_price(equipment.external_price)
        end
      end
    end
    xml_file
  end
end
