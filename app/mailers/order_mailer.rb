class OrderMailer < ApplicationMailer

  def order_updated_email(user)
    @user = user
    mail(to: @user.email, subject: "Your " + ENV['SITE_NAME'] + ' Order Has Been Updated")
  end
end
