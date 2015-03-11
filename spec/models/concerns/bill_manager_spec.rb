require 'rails_helper'

RSpec.describe BillManager, :type => :module do

  let (:group){FactoryGirl.create(:group)}
  let (:jef){FactoryGirl.create(:user)}
  let (:user){FactoryGirl.create(:user)}
  let (:args) {{group_id: group.id, user_id:jef.id, description: "Winkel",amount: 10}}

  context '.create_bill' do
    it "can create bills" do
      group.invite_member(jef)
      group.create_bill(args)
      expect(Bill.first.amount).to eq 10
      expect(Bill.first.user_id).to eq jef.id
      expect(Bill.first.description).to eq "Winkel"
      expect(Bill.first.group_id).to eq group.id
    end

    it "can not create bills for other groups" do
      group.create_bill(args)
      expect(Bill.all.size).to eq 0
    end
  end

  context '.bills' do
    it "shows all bills for the correct group" do
      group.invite_member(jef)
      Bill.create(amount:1, user_id:jef.id, group_id: group.id+1)
      group.create_bill(args)
      expect(group.bills.size).to eq 1
    end
  end

  context '.bills_for_member' do
    it "shows all groupbills for a member" do
      group.invite_member(jef)
      jefs_bill = group.create_bill(args)
      args[:user_id] = user.id
      group.create_bill(args)
      expect(group.bills_for_member(jef).size).to eq 1
      expect(group.bills_for_member(jef).first).to eq jefs_bill
    end
  end
end