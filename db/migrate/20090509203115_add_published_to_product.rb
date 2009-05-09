class AddPublishedToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :published, :boolean, :default => false
  end

  def self.down
    remove_column :products, :published
  end
end
