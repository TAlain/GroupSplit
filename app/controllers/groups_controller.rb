class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(owner_id: current_user.id, name:params[:group][:name])
    if @group.save
      current_user.groups << @group
      redirect_to new_group_url
    else
      render :action => "new"
    end
  end

  def show
    @group = Group.find(params[:id])
    redirect_to @group.url
  end
end
