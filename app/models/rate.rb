class Rate < ActiveRecord::Base
  belongs_to :rateable, :polymorphic => true
  belongs_to :user
  validates_inclusion_of :rating, :in => (1..5)
end
