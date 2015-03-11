class ExpenseCalculator
attr_accessor :group

  def initialize(group)
    @group = group
  end

  def total_for_group
    calculate_a_total_for{@group.bills}
  end

  def total_for_groupmember(member)
     calculate_a_total_for{@group.bills_for_member(member)}
  end

  def split_up_expenses
    split_expenses = Hash.new
    @group.users.each do |user|
      split_expenses[user.username.to_sym] = calculate_user_share(user)
    end
    split_expenses
  end

   private
      def calculate_user_share(user)
        total_payed_per_user_for - total_for_groupmember(user)
      end

      def total_payed_per_user_for
        total_for_group / @group.users.size
      end

      def calculate_a_total_for
        total=0
        yield.each do |bill|
          total += bill.amount if @group.users.include?(User.find bill.user_id)
        end
        total
      end
end