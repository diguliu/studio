class CreateEquipment < ActiveRecord::Migration
  def self.up
    create_table :equipment do |t|
      t.string  :model
      t.text    :description
      t.string  :equipment_type
      t.float   :external_price, :null => false 
      t.float   :internal_price, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :equipment
  end
end
