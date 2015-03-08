require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do

  login_user

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
    let(:user) { User.first }

    it "should return the correct response" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      expect(response).to have_http_status(302)
    end

    it "should redirect to the index action" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      expect(response).to redirect_to action: :new
    end

    it "should save the group" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      expect(Group.all.count).to equal(1)
    end

    it "should add owner to group membership" do
      post :create, owner_id: user.id, :group => { :name => 'testgrp' }
      expect(user.groups.first.id).to eq(Group.first.id)
    end
  end

end
