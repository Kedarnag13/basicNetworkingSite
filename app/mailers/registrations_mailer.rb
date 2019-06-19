class RegistrationsMailer < ApplicationMailer

  def send_password(member)
    @member = member
    email = @member.email
    mail to: email, subject: 'Welcome Email' 
  end

end
