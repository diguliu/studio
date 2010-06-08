class CreateAgendas < ActiveRecord::Migration
  def self.up
    create_table :agendas do |t|
      t.integer   :service_id, :null => false
      t.string    :band_login, :null => false
      t.datetime  :time, :null => false
      t.integer   :duration, :null => false
      t.integer   :room, :null => false
      t.string    :status, :null => false
      t.float     :total_price
      t.timestamps
    end
  end

  def self.down
    drop_table :agendas
  end
end
