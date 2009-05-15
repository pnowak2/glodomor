class User < ActiveRecord::Base
  has_many :orders, :include => :line_items
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "40x40>" }

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
end
