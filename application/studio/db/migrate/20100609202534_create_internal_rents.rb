class CreateInternalRents < ActiveRecord::Migration
  def self.up
    create_table :internal_rents do |t|
      t.datetime    :start
      t.integer     :duration
      t.references  :agenda
      t.references  :equip

      t.timestamps
    end
  end

  def self.down
    drop_table :internal_rents
  end
end
