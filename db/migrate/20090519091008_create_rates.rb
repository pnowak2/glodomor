class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.integer :rating,  :default => 0, :null => false
      t.integer :rateable_id
      t.string :rateable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :rates
  end
end
