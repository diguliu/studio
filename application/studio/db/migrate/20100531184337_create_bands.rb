class CreateBands < ActiveRecord::Migration
  def self.up
    create_table :bands do |t|
      t.string :login, :null => false
      t.string :name, :null => false
      t.string :style
      t.string :homepage
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bands
  end
end
