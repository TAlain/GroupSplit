class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  def invite new_member
    users << new_member
  end
end