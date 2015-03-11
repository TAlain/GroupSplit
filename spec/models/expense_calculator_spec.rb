require "rails_helper"

RSpec.describe Group, :type => :model do

  let (:group){FactoryGirl.build(:group)}
  let (:user){FactoryGirl.create(:user,username:'user')}
  let (:jef){FactoryGirl.create(:user,username:'jef')}
  let (:jos){FactoryGirl.create(:user,username:'jos')}
  let (:bill_args) {{group_id: group.id, description: "Winkel"}}
  let (:calculator) {FactoryGirl.build(:expense_calculator, group: group)}

  before(:each) do
    group.users << [user,jef,jos]
    group.create_bill(bill_args.merge(user_id: user.id, amount: 10))
    group.create_bill(bill_args.merge(user_id: jef.id, amount: 15))
    group.create_bill(bill_args.merge(user_id: jos.id, amount: 5))
  end

  context "#total_for_group" do
    it 'returns the total expenses for a group' do
      expect(calculator.total_for_group).to eq 30
    end
  end

  context "#total_payed_by" do
    it'calculates total expenses payed by user' do
      expect(calculator.total_for_groupmember(jef)).to eq 15
    end
  end

  context "#split_up_expenses" do
    it"splits up all expenses amongst the group's users" do
      expected={ User: 0, Jef: -5, Jos: 5}
      expect(calculator.split_up_expenses).to eq expected
    end

    it"can be called from group" do
      expected={ User: 0, Jef: -5, Jos: 5}
      expect(group.calculate_split_expenses).to eq expected
    end
  end
end