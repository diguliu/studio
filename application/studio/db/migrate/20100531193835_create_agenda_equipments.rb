class CreateAgendaEquipments < ActiveRecord::Migration
  def self.up
    create_table :agenda_equipments, :id => false do |t|
      t.references  :agenda
      t.references  :equipment
      t.integer     :duration, :null => false
      t.datetime    :time, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :agenda_equipments
  end
end
