class StaffTicketsController < ApplicationController
  def new
  end

  def create
    omniauth_params = request.env['omniauth.auth'].info

    order_data = {
      email: omniauth_params[:email],
      first_name: omniauth_params[:firstName],
      last_name: omniauth_params[:lastName]
    }

    if User.exists?(email: order_data[:email])
      redirect_to new_user_session_url, alert: "You have already signed up. Please check your email for a message to confirm your account. Contact support for help."
    else
      Arena::Order.new.process(order_data)
      redirect_to new_user_session_url, notice: "You should receive an email at #{order_data[:email]} shortly to finish creating your account."
    end
  end

  def failure
    redirect_to new_user_session_url, alert: "Invalid Login Credentials"
  end
end
