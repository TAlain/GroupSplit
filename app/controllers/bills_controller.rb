class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :edit, :destroy]

  def index
    @bills = Bill.filter(params.slice(:user_id, :group_id))
    @group = Group.find(params[:group_id]) if params[:group_id]
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

  def edit
    @bill = Bill.find(params[:id])
    @group = Group.find(@bill.group_id)
  end

  def update
    @bill = Bill.find(params[:id])
    @bill.update(update_bill_params)
    if @bill.save
      redirect_to @bill, notice: 'Bill was successfully updated.'
    else
      redirect_to edit_bill_path(@bill.id), notice: 'Fill in amount and description please.'
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
      description: params[:bill][:description],
      date: params[:bill][:date]}
    end

    def update_bill_params
      {amount: params[:bill][:amount],
       user_id: params[:user_id],
       description: params[:bill][:description],
       date: params[:bill][:date]}
    end
end
