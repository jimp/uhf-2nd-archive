class SiteMailer < ActionMailer::Base

  def admin_message(message)
    recipients  message.recipients
    from        message.from
    subject     message.subject
    cc          message.cc
    bcc         message.bcc
    body        :message => message
  end

  # This is the email that is sent when a user fills out the "sign the guestbook" form
  def guestbook(message)
    recipients  ADMIN_EMAIL
    from        message[:email]
    subject     "Guestbook from " + message[:email]
    body        :message => message[:message]
  end

  # This is the email that is sent when a person fills out the 
  # "email this page" form
  # <tt>message</tt>: the Message object that was generated by the form and saved
  # <tt>url</tt>: the url of the page that was sent
  def page(message, url)
    recipients  message.recipients
    from        ADMIN_EMAIL
    subject     message.subject
    body        :message => message, :url => url
  end
end
