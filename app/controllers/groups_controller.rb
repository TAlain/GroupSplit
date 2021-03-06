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

  def index
    @groups = current_user.groups
    render :index
  end

  def update
    set_group
    new_member=User.where(username: params[:member_username].first.capitalize).first
    current_user.invite_member_to_group(new_member,@group)
    NotifyMailer.invited_to_group(new_member,@group).deliver

    redirect_to group_url(id: @group.id)
  end

  def show
    set_group
  end

  def leave_group
    set_group
    current_user.leave_group(@group)
    redirect_to groups_path
  end

  def destroy
    set_group
    current_user.destroy_group(@group)
    redirect_to new_group_url
  end

  def destroy_multiple_members
    set_group
    members_ids = params[:members_ids].split(',')
    current_user.kick_multiple_members(members_ids,@group)
    redirect_to group_url(id: @group.id)
  end

  def calculate_split_expenses
    set_group
    @group_split = @group.calculate_split_expenses
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end
end
