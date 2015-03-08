class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = current_user.create_group(params[:group][:name])
    if @group.save
      current_user.groups << @group
      redirect_to group_url(id: @group.id)
    else
      render :action => "new"
    end
  end

  def update
    set_group
    new_member=User.where(username: params[:member_username].capitalize)
    current_user.invite_member_to_group(new_member,@group)

    redirect_to group_url(id: @group.id)
  end

  def show
    set_group
  end

  def destroy
    set_group
    current_user.destroy_group(@group)
    redirect_to new_group_url
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
