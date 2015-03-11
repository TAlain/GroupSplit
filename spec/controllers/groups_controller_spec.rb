require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do

  login_user
  let(:user) { User.first }
  let(:jef) {FactoryGirl.build(:user, username: "Jef")}
  let(:jos) {FactoryGirl.build(:user, username: "Jos")}
  let(:group) {FactoryGirl.create(:group, owner_id: user.id)}

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "should render the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    it "should return the correct response" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      expect(response).to have_http_status(302)
    end

    it "should redirect to the new action" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      testgrp=Group.where(name: 'testgrp').first
      expect(response).to redirect_to group_url(id: testgrp.id)
    end

    it "should save the group" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      expect(Group.all.count).to equal(1)
    end

    it "should add owner to group membership" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      testgrp=Group.where(name: 'testgrp').first
      expect(user.groups.first.id).to eq(testgrp.id)
    end
  end

  describe "POST #show" do
    it "should return the correct response" do
      post :show, id: group.id
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end
  end

  describe "POST #update" do
    it "can invite new members to group" do
      jef.save
      post :update, id: group.id, member_username: ["jef"]
      expect(group.users).to include jef
      expect(response).to redirect_to group_url(id: group.id)
    end
  end

  describe "POST #destroy" do
    it "should destroy the group" do
      post :destroy, id: group.id
      expect(Group.all.size).to eq 0
      expect(response).to redirect_to action: :new
    end
  end

  describe "POST #destroy_multiple_members" do
    it "should remove multiple members" do
      group.users << [jef,jos]
      post :destroy_multiple_members, id: group.id, members_ids: "#{jef.id},#{jos.id}"
      expect(group.users.size).to eq 0
    end
  end

end
