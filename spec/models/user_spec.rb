require 'rails_helper'

RSpec.describe User, :type => :model do

     let(:user){FactoryGirl.build(:user)}

    it "should have a valid factory" do
      expect(user).to be_valid
    end

    it "should be able to create a group" do
      mygroup = user.create_group("MyGroup")
    expect(mygroup).to eq(Group.where(name:"MyGroup").first)
    expect(mygroup.owner_id).to eq(user.id)
    end

    it "should be able to send invite for your groups" do
      group = instance_double(Group,owner_id: user.id)
      expect(group).to receive(:invite).with('jef')
      user.invite_member_to_group('jef',group)
    end

    it "should not be able to send invite for other groups" do
      group = instance_double(Group, owner_id: "not_user")
      expect{user.invite_member_to_group('jef',group)}.to raise_error(RuntimeError,"You are not the owner of this group.")
    end

end
