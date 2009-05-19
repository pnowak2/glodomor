class AddUserIdToRate < ActiveRecord::Migration
  def self.up
    add_column :rates, :user_id, :integer
  end

  def self.down
    remove_column :rates, :user_id
  end
end
