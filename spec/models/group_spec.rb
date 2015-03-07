require 'rails_helper'

RSpec.describe Group, :type => :model do

      let (:group){FactoryGirl.build(:group)}
      let (:user){FactoryGirl.build(:user)}
      let (:jef){FactoryGirl.build(:user)}

    it "has a valid factory" do
      expect(group).to be_valid
    end

  context '.destroy_self' do
    it "can delete an active_record of Group" do
      johnny5 = Group.create(name:"Short Circuit")
      johnny5.destroy_self
      expect(Group.all.size).to eq 0
    end
  end

  context '.invite_member' do
    it "can add users" do
      group.invite_member(jef)
      expect(group.users.include? jef).to be_truthy
    end
    it "can not add same user twice" do
      group.invite_member(jef)
      group.invite_member(jef)
      expect(group.users.size).to eq 1
    end
  end

  context '.kick_member' do
    it "can remove members" do
      group.users << jef
      group.kick_member(jef)
      expect(group.users.size).to eq(0)
    end
  end

  context '.create_bill' do
    it "can create bills" do
      group.users << jef
      group.create_bill(jef, 10)
      expect(Bill.first.amount).to eq 10
      expect(Bill.first.user_id).to eq jef.id
      expect(Bill.first.group_id).to eq group.id
    end

    it "can not create bills for other groups" do
      group.create_bill(jef, 10)
      expect(Bill.all.size).to eq 0
    end
  end

  context '.bills' do
    it "shows all bills for the correct group" do
      group.users << jef
      Bill.create(amount:1, user_id:jef.id, group_id: group.id+1)
      group.create_bill(jef, 10)
      expect(group.bills.size).to eq 1
    end
  end

 context '.bills_for_member' do
   it "shows all groupbills for a member" do
     group.users << jef
     jefs_bill = group.create_bill(jef, 10)
     group.create_bill(user, 10)
     expect(group.bills_for_member(jef).size).to eq 1
     expect(group.bills_for_member(jef).first).to eq jefs_bill
   end
 end
end