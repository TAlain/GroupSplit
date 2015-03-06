require 'rails_helper'

RSpec.describe Group, :type => :model do

      let(:group){FactoryGirl.build(:group)}
      let (:jef){FactoryGirl.build(:user)}

      it "should have a name" do
      expect(group.name).to eq("Girl's Group")
    end

    it "should be able to add users" do
      group.invite(jef)
      expect(group.users.include? jef). to be_truthy
    end
end