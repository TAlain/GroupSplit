class Bill < ActiveRecord::Base
  include Filterable
  belongs_to :user
  belongs_to :group
  validates :description,:presence => true
  validates :amount,:presence => true
  validates :group_id,:presence => true
  validates :user_id,:presence => true
  scope :user_id, -> (user_id) { where user_id: user_id }
  scope :group_id, -> (group_id) { where group_id: group_id }
end