class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :login, :null => false
      t.string :password, :null => false
      t.timestamps
      t.references :person
    end
  end

  def self.down
    drop_table :clients
  end
end
