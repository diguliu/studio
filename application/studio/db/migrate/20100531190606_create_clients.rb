class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :login, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.string :roles, :default => "client"
      t.timestamps
      t.references :person
    end
  end

  def self.down
    drop_table :clients
  end
end
