class ExpenseCalculator

  def self.total_for_group(group)
    calculate_a_total_for{group.bills}
  end

  def self.total_for_groupmember(group, member)
     calculate_a_total_for{group.bills_for_member(member)}
  end

  def self.split_up_expenses(group)
    split_expenses = Hash.new
    group.users.each do |user|
      split_expenses[user.username.to_sym] = calculate_user_share(group, user)
    end
    split_expenses
  end

   private
      def self.calculate_user_share(group, user)
        total_payed_per_user_for(group) - total_for_groupmember(group, user)
      end

      def self.total_payed_per_user_for(group)
        total_for_group(group) / group.users.size
      end

      def self.calculate_a_total_for
        total=0
        yield.each do |bill|
          total += bill.amount
        end
        total
      end
end