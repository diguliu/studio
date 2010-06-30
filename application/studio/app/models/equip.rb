class Equip < ActiveRecord::Base
  validates_presence_of :external_price, :internal_price, :classification

  has_many :internal_rents
  has_many :agendas, :through => :internal_rents
  has_many :external_rents
  has_many :clients, :through => :external_rents

  def self.xml_equips
    xml_file = ""
    xml = Builder::XmlMarkup.new(:target => xml_file, :indent => 2)
    xml.equips do
      Equip.all.each do |equip|
        xml.equip do
          xml.model(equip.model)
          xml.description(equip.description)
          xml.classification(equip.classification)
        end
      end
    end
    xml_file
  end
end
