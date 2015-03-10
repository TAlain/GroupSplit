class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = Bill.all
  end

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bill.new(bill_params)

    if @bill.save
      redirect_to @bill, notice: 'Bill was successfully created.'
    else
      render :new
    end
    # respond_to do |format|
    #   if @bill.save
    #     format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
    #     format.json { render :show, status: :created, location: @bill }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @bill.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      {amount: params[:bill][:amount],
       user_id: params[:user_id],
       group_id: params[:groups_select],
      description: params[:bill][:description]}
    end
end
