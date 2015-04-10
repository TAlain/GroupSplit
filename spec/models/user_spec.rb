require 'rails_helper'

RSpec.describe User, :type => :model do

     let(:user){FactoryGirl.create(:user)}
     let (:group){FactoryGirl.build(:group)}


     it "has a valid factory" do
       expect(user).to be_valid
     end

     it "save username with capital first letter" do
       expect(FactoryGirl.create(:user, username: "jos").username).to eq "Jos"
     end
      it "has a unique username" do
        expect{FactoryGirl.create(:user, username: user.username)}.to raise_error(ActiveRecord::RecordInvalid,"Validation failed: Username has already been taken")
      end

     it "has a username with no white space" do
       expect{FactoryGirl.create(:user, username: "JOS BOS")}.to raise_error(ActiveRecord::RecordInvalid,"Validation failed: Attribute No empty spaces please")
     end

     it "has a username with no white space" do
       group.invite_member(user)
       expect(group.users.include? user).to be_truthy
       user.leave_group(group)
       expect(group.users.include? user).to be_falsey
     end
end
