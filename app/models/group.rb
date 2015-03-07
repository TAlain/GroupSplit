class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  def invite_member new_member
    users << new_member if !users.include? new_member
  end

  def kick_member member
    users.delete(member) if users.include? member
  end

  def create_bill member, amount
    Bill.create(user_id: member.id,amount: amount, group_id: self.id) if users.include? member
  end
end