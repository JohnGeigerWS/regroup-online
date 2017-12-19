class LiveController < ApplicationController
  before_action :authenticate_user!
  def index
    @live_state    = LiveState.get_current_state
    @live_timeslot = Timeslot.live

    session  = Session.find( params[:session] ) if params[:session].present?
    session  = @live_timeslot.sessions.first if (session.nil? && @live_timeslot.present?)
    session  = Session.new unless session

    @live_session  = SessionPresenter.new( session )

    @schedule = Timeslot.order(:start_time)
                        .includes(sessions: :assets)
                        .group_by {|timeslot| timeslot.start_time.strftime("%A")}
  end
end
