class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  def destroy_self
    Group.find(self.id).destroy
  end

  def invite_member new_member
    users << new_member if !users.include? new_member
  end

  def kick_member member
    users.delete(member) if users.include? member
  end

  def create_bill member, amount
    Bill.create(user_id: member.id,amount: amount, group_id: self.id) if users.include? member
  end

  def bills
    Bill.where(group_id: self.id).all
  end

  def bills_for_member(member)
    bills.where(user_id: member.id).all
  end

  def calculate_split_expenses
    ExpenseCalculator.split_up_expenses(self)
  end
end