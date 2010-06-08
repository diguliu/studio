class CreateClientEquipments < ActiveRecord::Migration
  def self.up
    create_table :client_equipments, :id => false do |t|
      t.references  :client
      t.references  :equipment
      t.integer     :duration, :null => false
      t.datetime    :time, :null => false
      t.float       :total_price
      t.string      :status, null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :client_equipments
  end
end
