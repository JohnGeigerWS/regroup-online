class TicketsController < ApplicationController
  before_action :ticket_params, only: [:update]

  def index
    @user = current_user
  end

  def create
    # force invite for now from params
    invite_user = User.find(params[:invite_user])
    invite_data = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email]
    }

    User.invite!(invite_data, invite_user)
    redirect_to tickets_url
  end

  def update
    invite_user = User.find(ticket_params[:invite_user])
    invite_data = {
      first_name: ticket_params[:first_name],
      last_name: ticket_params[:last_name],
      email: ticket_params[:email]
    }
    currently_invited_user = User.find(ticket_params[:currently_invited_user]).destroy

    User.invite!(invite_data, invite_user)
    redirect_to tickets_url
  end

  private
    # TODO: pick up here
    def ticket_params
      params.require(:user).permit(:first_name, :last_name, :email, :invite_user, :currently_invited_user)
    end
end
