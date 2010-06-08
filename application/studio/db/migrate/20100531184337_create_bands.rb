class CreateBands < ActiveRecord::Migration
  def self.up
    create_table :bands, :primary_key => :login do |t|
      t.string :name, :null => false
      t.string :style
      t.string :homepage
      t.string :password, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bands
  end
end
