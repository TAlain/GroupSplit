class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = Bill.filter(params.slice(:user_id, :group_id))
  end

  def new
    @bill = Bill.new
    @group = Group.find(params[:group_id])
  end

  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      redirect_to @bill, notice: 'Bill was successfully created.'
    else
      redirect_to new_bill_path(group_id: @bill.group.id), notice: 'Fill in amount and description please.'
    end
  end

  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def bill_params
      {amount: params[:bill][:amount],
       user_id: params[:user_id],
       group_id: params[:groups_select],
      description: params[:bill][:description]}
    end
end
