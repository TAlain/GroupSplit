require 'rails_helper'

RSpec.describe GroupOwner, :type => :module do

  let(:user){FactoryGirl.build(:user)}
  let(:jef){FactoryGirl.build(:user)}
  let(:users_group){FactoryGirl.build(:group, owner_id: user.id)}

  context '.create_group' do

    it "can create a group" do
      mygroup = user.create_group("MyGroup")
      expect(mygroup).to eq(Group.where(name:"MyGroup").first)
      expect(mygroup.owner_id).to eq(user.id)
    end
  end

  context '.invite_member_to_group' do
    it "can send an invite for your groups" do
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

  let(:jef2){FactoryGirl.create(:user)}
  context '.kick_multiple_members' do
    it 'can remove multiple members at once' do
      expect(users_group).to receive(:kick_member).twice
      jef.save
      user.save
      user.kick_multiple_members([jef,jef2],users_group)
    end
  end

  context '.destroy_group' do
    it "can destroy an owned group" do
      users_group.save
      expect{user.destroy_group(users_group)}.to change(Group, :count).by(-1)
    end

    it "can not destroy a non-owned group" do
      expect{jef.destroy_group(users_group)}.to raise_error(RuntimeError,"You are not the owner of this group.")
    end
  end
end