class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :line_items
  has_many :rates, :as => :rateable
  has_many :comments, :as => :commentable
  has_many :properties
  has_attached_file :photo, :styles => { :medium => "80x80#", :thumb => "40x40#" }
    
  named_scope :available, :conditions => ["published = :published and (inventory is null or inventory > :inventory)", {:inventory => 0, :published => true} ]
  named_scope :recent,
              lambda {|*args| {:conditions => ["created_at > ?", (args.first || 2.days.ago)], :limit => 3 } }

  def picture(mode=nil)     
      if(self.photo?)
        self.photo.url(mode)
      else
        case (mode)
          when :thumb
            "/images/information-icon.gif"
          when :medium
            "/images/rails.png"
          else
            "/images/rails.png"
        end
      end
  end
  
  def available?(quantity=nil)
    (self.inventory == nil || self.inventory > 0) && ((quantity && self.inventory) ? self.inventory >= quantity : true)
  end
  
  def rating_avg
    size = self.rates.count
    if(size > 0)
      return (self.rates.map(&:rating).sum.to_f / size)
    else
      return 0
    end
  end

  def prices
    self.properties.map {|p| p.price}.join("/")
  end
  
  def to_s
    self.name
  end
end
