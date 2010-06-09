class BandsMembers < ActiveRecord::Migration
  def self.up
    create_table :bands_members, :id => false do |t|
      t.references :band
      t.references :member
    end
  end

  def self.down
    drop_table :bands_members
  end
end
