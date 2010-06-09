class CreateAgendas < ActiveRecord::Migration
  def self.up
    create_table :agendas do |t|
      t.datetime  :start, :null => false
      t.integer   :duration, :null => false
      t.integer   :room, :null => false
      t.string    :status, :null => false
      t.float     :total_price
      t.timestamps
      t.references :band
      t.references :service
    end
  end

  def self.down
    drop_table :agendas
  end
end
