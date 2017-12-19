class SupportRequestMailer < ApplicationMailer

  def support_request_created_email(support_request)

    @support_request = support_request

    admin_email = ENV["ADMIN_EMAIL"]
    
    if admin_email
      mail(to: admin_email, subject: "A Drive Online support request was submitted")
    end

  end

end
