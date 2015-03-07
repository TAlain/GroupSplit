require "rails_helper"

RSpec.describe Group, :type => :model do

  let (:group){FactoryGirl.build(:group)}
  let (:user){FactoryGirl.build(:user)}
  let (:jef){FactoryGirl.build(:user)}

  before(:each) do
    group.users << [user,jef]
    group.create_bill(user, 10)
    group.create_bill(jef, 15)
    group.create_bill(user, 5)
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
end