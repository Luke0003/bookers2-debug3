class EventMailer < ApplicationMailer
  default from: 'オーナー<from@example.com>'
  def send_notification(group, title, content)
    @group = group
    @title = title
    @content = content
    mail(to: @group.users.pluck(:email), subject: "New Event Notice!")
  end
end
