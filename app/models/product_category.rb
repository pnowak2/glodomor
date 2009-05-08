class ProductCategory < ActiveRecord::Base
  has_many :products
  
  def to_s
    self.name
  end
end
