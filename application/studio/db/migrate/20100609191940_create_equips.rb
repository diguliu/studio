class CreateEquips < ActiveRecord::Migration
  def self.up
    create_table :equips do |t|
      t.string  :model
      t.string  :description
      t.string  :classification, :null => false
      t.float   :external_price, :null => false
      t.float   :internal_price, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :equips
  end
end
