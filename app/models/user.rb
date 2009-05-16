class User < ActiveRecord::Base
  has_many :orders, :include => :line_items
  has_attached_file :avatar, :styles => { :medium => "150x150>", :thumb => "40x40>" }

  named_scope :recent,
              lambda {|*args| {:order => "id desc", :limit => 3 } }
  named_scope :recently_logged,
              lambda {|*args| {:conditions => ["last_request_at > ?", (args.first || 5.minutes.ago)], :limit => 3 } }
  acts_as_authentic
  
  def is_admin?
    self.role == User.ROLES[:admin]
  end
  
  def self.ROLES
    {:admin => 'admin', :user => 'user'}
  end
  
  def picture(mode=nil)     
      if(self.avatar?)
        self.avatar.url(mode)
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
    self.first_name + " " + self.last_name
  end

end
