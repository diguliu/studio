class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string  :cpf, :null => false
      t.string  :name, :null => false
      t.string  :type, :null => false
      t.text    :address
      t.string  :email
      t.string  :gender
      t.string  :phone1
      t.string  :phone2
      t.string  :login, :null => false
      t.string  :crypted_password, :null => false
      t.string  :password_salt, :null => false
      t.string  :persistence_token, :null => false
      t.string  :roles, :default => "client"
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
