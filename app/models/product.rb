class Product < ActiveRecord::Base
  belongs_to :product_category
  named_scope :published, :conditions => { :published => true }
  
  def to_s
    self.name
  end
end
