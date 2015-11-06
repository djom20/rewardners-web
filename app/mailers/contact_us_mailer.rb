class ContactUsMailer < ApplicationMailer

  default to: "your@address.com"

  def new_message(message)
    @message = message
    mail(subject: @message.message_title, from: @message.email)
  end

end
