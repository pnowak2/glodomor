class Product < ActiveRecord::Base
  belongs_to :product_category
  
  def to_s
    self.name
  end
end
