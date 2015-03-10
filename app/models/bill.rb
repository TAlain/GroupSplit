class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates :description,:presence => true
  validates :amount,:presence => true
  validates :group_id,:presence => true
  validates :user_id,:presence => true
end