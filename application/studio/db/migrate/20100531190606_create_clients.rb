class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients, :primary_key => :login do |t|
      t.string :person_cpf, :null => false
      t.string :password, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
