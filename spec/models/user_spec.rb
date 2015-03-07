require 'rails_helper'

RSpec.describe User, :type => :model do

     let(:user){FactoryGirl.build(:user)}
     let(:jef){FactoryGirl.build(:user)}

     it "has a valid factory" do
       expect(user).to be_valid
     end

  context '.create_group' do

      it "can create a group" do
        mygroup = user.create_group("MyGroup")
        expect(mygroup).to eq(Group.where(name:"MyGroup").first)
        expect(mygroup.owner_id).to eq(user.id)
      end
  end

  context '.invite_member_to_group' do

      it "can send an invite for your groups" do
        group = instance_double(Group,owner_id: user.id)
        expect(group).to receive(:invite_member).with(jef)
        user.invite_member_to_group(jef,group)
      end

      it "can not send an invite for other groups" do
       group = instance_double(Group, owner_id: "not_user")
       expect{user.invite_member_to_group('jef',group)}.to raise_error(RuntimeError,"You are not the owner of this group.")
      end
  end

  context '.remove_member_from_group' do
      it "can remove a member from own groups" do
        group = instance_double(Group,owner_id: user.id)
        expect(group).to receive(:kick_member).with('jef')
        user.remove_member_from_group('jef',group)
      end

      it "can not send an invite for other groups" do
        group = instance_double(Group, owner_id: "not_user")
        expect{user.remove_member_from_group('jef',group)}.to raise_error(RuntimeError,"You are not the owner of this group.")
      end
  end

  context '.create_bill' do
    let (:group){FactoryGirl.build(:group)}
    it "sends a create_bill message to group" do
      user.groups << group
      expect(group).to receive(:create_bill).with(user)
      user.create_bill(group)
    end
  end
end
