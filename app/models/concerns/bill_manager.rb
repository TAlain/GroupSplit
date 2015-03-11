module BillManager

  def create_bill args
    Bill.create(args) if users.include? User.find(args[:user_id])
  end

  def bills
    Bill.where(group_id: self.id).all
  end

  def bills_for_member(member)
    bills.where(user_id: member.id).all
  end

  def calculate_split_expenses
    calculator.split_up_expenses
  end

  private
  def calculator
    ExpenseCalculator.new(self)
  end
end