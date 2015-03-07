require "rails_helper"

RSpec.describe Group, :type => :model do

  let (:group){FactoryGirl.build(:group)}
  let (:user){FactoryGirl.build(:user,username:'user')}
  let (:jef){FactoryGirl.build(:user,username:'jef')}
  let (:jos){FactoryGirl.build(:user,username:'jos')}

  before(:each) do
    group.users << [user,jef,jos]
    group.create_bill(user, 10)
    group.create_bill(jef, 15)
    group.create_bill(jos, 5)
  end

  context "#total_for_group" do
    it 'returns the total expenses for a group' do
      expect(ExpenseCalculator.total_for_group(group)).to eq 30
    end
  end

  context "#total_payed_by" do
    it'calculates total expenses payed by user' do
      expect(ExpenseCalculator.total_for_groupmember(group,jef)).to eq 15
    end
  end

  context "#split_up_expenses" do
    it"splits up all expenses amongst the group's users" do
      expected={jef: -5, jos: 5, user: 0}
      expect(ExpenseCalculator.split_up_expenses(group)).to eq expected
    end
  end
end