class AddProductCategoryToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :product_category_id, :integer
  end

  def self.down
    remove_column :products, :product_category
  end
end
