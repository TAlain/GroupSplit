require 'rails_helper'

RSpec.describe Group, :type => :model do

      let (:group){FactoryGirl.create(:group)}
      let (:user){FactoryGirl.create(:user)}
      let (:jef){FactoryGirl.create(:user)}
      let (:args) {{group_id: group.id, user_id:jef.id, description: "Winkel",amount: 10}}

    it "has a valid factory" do
      expect(group).to be_valid
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
      group.invite_member(jef)
      group.kick_member(jef)
      expect(group.users.size).to eq(0)
    end

    it "will also remove bills from the member" do
      group.invite_member(jef)
      group.create_bill(args)
      group.kick_member(jef)
      expect(Bill.all.size).to eq 0
    end
  end
end