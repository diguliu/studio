class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.datetime :start_at, :null => false
      t.datetime :end_at, :null => false
      t.references :agenda
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
