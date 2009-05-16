class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :line_items
  has_attached_file :photo, :styles => { :medium => "150x150#", :thumb => "40x40#" }
    
  named_scope :published, :conditions => { :published => true }
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
    def to_s
    self.name
  end
end
