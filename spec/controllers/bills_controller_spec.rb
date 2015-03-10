require 'rails_helper'

RSpec.describe BillsController, :type => :controller do
  login_user
  let(:user) { User.first }
  let(:valid_attributes) {{
    amount: 4,
    user_id: user.id,
    group_id: 1
  }}
  let(:invalid_attributes) {{
    :user_id => nil,
    :group_id => nil

  }}

  describe "GET index" do
    it "assigns all bills as @bills" do
      bill = Bill.create! valid_attributes
      get :index, {}
      expect(Bill.first).to eq(bill)
    end
  end

  describe "GET show" do
    it "assigns the requested bill as @bill" do
      bill = Bill.create! valid_attributes
      get :show, {:id => bill.to_param}
      expect(assigns(:bill)).to eq(bill)
    end
  end

  describe "GET new" do
    it "assigns a new bill as @bill" do
      get :new
      expect(assigns(:bill)).to be_a_new(Bill)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bill" do
        expect {
          post :create, {:bill => {amount: 5}, groups_select:5 , user_id:2}
        }.to change(Bill, :count).by(1)
      end

      it "assigns a newly created bill as @bill" do
        post :create, {:bill => {amount: 5}, groups_select:5 , user_id:2}
        expect(assigns(:bill)).to be_a(Bill)
        expect(assigns(:bill)).to be_persisted
      end

      it "redirects to the created bill" do
        post :create, {:bill => {amount: 5}, groups_select:5 , user_id:2}
        expect(response).to redirect_to(Bill.last)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bill" do
      bill = Bill.create! valid_attributes
      expect {
        delete :destroy, {:id => bill.to_param}
      }.to change(Bill, :count).by(-1)
    end

    it "redirects to the bills list" do
      bill = Bill.create! valid_attributes
      delete :destroy, {:id => bill.to_param}
      expect(response).to redirect_to(bills_url)
    end
  end

end
