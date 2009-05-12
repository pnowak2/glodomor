class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :line_items
  named_scope :published, :conditions => { :published => true }
  
  def to_s
    self.name
  end
end
