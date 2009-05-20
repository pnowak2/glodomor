class Message < ActiveRecord::Base
  named_scope :recent,
              lambda {|*args| {:order => "id desc", :limit => 3 } }
end
