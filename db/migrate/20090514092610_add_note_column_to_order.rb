class AddNoteColumnToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :note, :text
  end

  def self.down
    remove_column :orders, :note
  end
end
