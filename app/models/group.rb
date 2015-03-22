class Group < ActiveRecord::Base
  include BillManager
  has_and_belongs_to_many :users
  validates :name, :presence => true

  def invite_member new_member
    users << new_member if !users.include? new_member
  end

  def kick_member member
    users.delete(member) if users.include? member
    bills.where(user_id: member.id).destroy_all
  end

end