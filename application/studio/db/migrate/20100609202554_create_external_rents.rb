class CreateExternalRents < ActiveRecord::Migration
  def self.up
    create_table :external_rents do |t|
      t.datetime    :start
      t.integer     :duration
      t.string      :status
      t.float       :price
      t.references  :client
      t.references  :equip

      t.timestamps
    end
  end

  def self.down
    drop_table :external_rents
  end
end
