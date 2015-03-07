require 'rails_helper'

RSpec.describe User, :type => :model do

     let(:user){FactoryGirl.build(:user)}
     let(:jef){FactoryGirl.build(:user)}
     let(:users_group){FactoryGirl.build(:group, owner_id: user.id)}

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
        # group = instance_double(Group,owner_id: user.id)
        expect(users_group).to receive(:invite_member).with(jef)
        user.invite_member_to_group(jef,users_group)
      end

      it "can not send an invite for other groups" do
       expect{jef.invite_member_to_group(user,users_group)}.to raise_error(RuntimeError,"You are not the owner of this group.")
      end
  end

  context '.remove_member_from_group' do
      it "can remove a member from own groups" do
        expect(users_group).to receive(:kick_member).with(jef)
        user.remove_member_from_group(jef,users_group)
      end

      it "can not remove a member for not-owned groups" do
        expect{jef.remove_member_from_group(jef,users_group)}.to raise_error(RuntimeError,"You are not the owner of this group.")
      end
  end

   context '.destroy_group' do
     it "can destroy an owned group" do
       expect(users_group).to receive(:destroy_self)
       user.destroy_group(users_group)
     end

     it "can not destoy a non-owned group" do
       expect{jef.destroy_group(users_group)}.to raise_error(RuntimeError,"You are not the owner of this group.")
     end
   end

  context '.create_bill' do
    it "sends a create_bill message to group" do
      user.groups << users_group
      expect(users_group).to receive(:create_bill).with(user, 10)
      user.create_bill(users_group, 10)
    end
    it "can not create bills for other groups" do
      expect{jef.create_bill(user, 10)}.to raise_error(RuntimeError,"You are not a member of this group.")
    end
  end

end
