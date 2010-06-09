class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string  :cpf, :null => false
      t.string  :name, :null => false
      t.text    :address
      t.string  :email
      t.string  :gender
      t.string  :phone1
      t.string  :phone2
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
