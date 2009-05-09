class User < ActiveRecord::Base
  acts_as_authentic
  
  def is_admin?
    self.role == User.ROLES[:admin]
  end
  
  def self.ROLES
    {:admin => 'admin', :user => 'user'}
  end
end
