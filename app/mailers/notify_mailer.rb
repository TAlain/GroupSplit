class NotifyMailer < ActionMailer::Base
  default from: "groupsplitmailer@gmail.com"

  def invited_to_group(user, group)
    @user = user
    @group = group
    @inviter = User.where(id: group.owner_id).first
    mail(to: @user.email, subject: "You have been invited to #{@group.name}")
  end

  def removed_from_group(user, group)
    @user = user
    @group = group
    @inviter = User.where(id: group.owner_id).first
    mail(to: @user.email, subject: "You have been removed from #{@group.name}")
  end

end
