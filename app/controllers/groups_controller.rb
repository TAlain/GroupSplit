class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(owner_id: current_user.id, name:params[:group][:name])
    if @group.save
      current_user.groups << @group
      redirect_to group_url(id: @group.id)
    else
      render :action => "new"
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    current_user.destroy_group(@group)
    redirect_to new_group_url
  end
end
