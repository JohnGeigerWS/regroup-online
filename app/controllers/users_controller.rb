class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_params, only: [:update]

  def show
    @user = current_user
  end

  def create
    user = current_user
    invite_data = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      skip_invitation: true
    }

    if User.where(email: invite_data[:email]).exists?
      redirect_to account_url, alert: "An invitation has already been sent to #{invite_data[:email]}."
      return
    end

    invited_user = invite_user invite_data, current_user

    if invited_user
      redirect_to account_url, notice: "Your invited to #{invite_data[:email]} is on its way!"
    else
      redirect_to account_url, alert: "Please fill out form fields when sending an invitation."
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      sign_in user, bypass: true if current_user.id == user.id
      redirect_to account_url, notice: "Your account was updated."
    else
      redirect_to account_url, alert: ":'("
    end
  end

  def resend_invitation
    user = User.find(params[:user_id])
    user.invite!
    redirect_to :back, notice: "Invitation email re-sent to #{user.email}."
  end

  def revoke_invitation
    user = User.find(params[:user_id])
    email = user.email

    revoke_user_invitation user

    redirect_to :back, notice: "Ticket for #{email} was revoked"
  end

  private
    # TODO: pick up here
    def user_params
      # byebug
      params.require(:user).permit(:first_name, :last_name, :email, :org_name, :password, :password_confirmation)
    end

    def invite_user invited_user_data, invited_by
      invited_user = User.invite!(invited_user_data, invited_by)

      return nil if invited_user.nil? || invited_user.id.nil?

      unless invited_user.valid?
        revoke_user_invitation invited_user
        return nil
      end

      invited_user.deliver_invitation
      invited_user
    end

    def revoke_user_invitation user
      if user.invited_by
        inviter = user.invited_by
        inviter.update_attributes({invitation_limit: inviter.invitation_limit + 1})
      end

      user.destroy!
    end
end
