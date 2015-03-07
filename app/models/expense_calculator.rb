class ExpenseCalculator

  def self.total_for_group(group)
    calculate_a_total_for{group.bills}
  end

  def self.total_for_groupmember(group, member)
     calculate_a_total_for{group.bills_for_member(member)}
  end

  def self.calculate_a_total_for
    total=0
    yield.each do |bill|
      total += bill.amount
    end
    total
  end

end