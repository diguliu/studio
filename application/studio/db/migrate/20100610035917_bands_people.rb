class BandsPeople < ActiveRecord::Migration
  def self.up
    create_table :bands_people, :id => false do |t|
      t.references :band
      t.references :person
    end
  end

  def self.down
    drop_table :bands_people
  end
end
