# Preview all emails at http://localhost:3000/rails/mailers/notify_mailer
class NotifyMailerPreview < ActionMailer::Preview
  def invited_to_group
    NotifyMailer.invited_to_group(User.first, Group.first)
  end

  def removed_from_group
    NotifyMailer.removed_from_group(User.first, Group.first)
  end
end
