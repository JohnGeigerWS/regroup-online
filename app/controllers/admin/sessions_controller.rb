class Admin::SessionsController < Admin::BaseController
  before_action :set_session, only: [:edit, :update, :destroy]
  before_action :get_timeslots, only: [:edit, :new]
  before_action :get_communicators, only: [:edit, :new]

  # GET /admin/sessions
  def index
    @sessions = Session.all.includes(:timeslot).order('timeslots.start_time')
  end

  # GET /admin/sessions/new
  def new
    @session = Session.new
  end

  # GET /admin/sessions/1/edit
  def edit
  end

  # POST /admin/sessions
  def create
    @session = Session.new(session_params)

    if @session.save
      redirect_to admin_sessions_url, notice: 'Session was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/sessions/1
  def update
    if @session.update(session_params)
      redirect_to admin_sessions_url, notice: 'Session was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/sessions/1
  def destroy
    @session.destroy
    redirect_to admin_sessions_url, notice: 'Session was successfully deleted.'
  end

  # mark the session as finished
  def finish
    session = Session.find(params[:id])
    if session.finish!
      redirect_to admin_sessions_url
    else
      render :edit
    end
  end

  def restart
    session = Session.find(params[:id])
    if session.restart!
      redirect_to admin_sessions_url
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    def get_timeslots
      @timeslots = Timeslot.order(:start_time)
    end

    def get_communicators
      @communicators = Communicator.order(:name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(
        :title, :description, :permalink, :timeslot_id,
        presenters_attributes: [:communicator_id, :id, :position, :_destroy],
        assets_attributes: [:value, :id, :label, :kind, :name, :_destroy]
      )
    end
end
