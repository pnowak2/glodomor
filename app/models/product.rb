class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :line_items
  has_attached_file :photo, :styles => { :medium => "180x180", :thumb => "64x48>" }
    
  named_scope :published, :conditions => { :published => true }
  named_scope :recent,
              lambda {|*args| {:conditions => ["created_at > ?", (args.first || 2.days.ago)], :limit => 3 } }
  def to_s
    self.name
  end
end
