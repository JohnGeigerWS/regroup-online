class SessionsController < ApplicationController
  before_action :authenticate_user!
  def show
    @live_state = LiveState.get_current_state
    @session = Session.friendly.find(params[:id])
    @session_presenter = SessionPresenter.new @session
  end

  def check
    @session = Session.friendly.find(params[:id])
    render json: @session
  end
end
