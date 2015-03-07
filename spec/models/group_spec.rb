require 'rails_helper'

RSpec.describe Group, :type => :model do

      let(:group){FactoryGirl.build(:group)}
      let (:jef){FactoryGirl.build(:user)}
    it "has a valid factory" do
      expect(group).to be_valid
    end


  context '.invite_member' do
    it "can add users" do
      group.invite_member(jef)
      expect(group.users.include? jef). to be_truthy
    end
  end

  context '.kick_member' do
    it "can remove members" do
      group.users << jef
      group.kick_member(jef)
      expect(group.users.size).to eq(0)
    end
  end
end