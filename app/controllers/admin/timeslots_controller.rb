class Admin::TimeslotsController < Admin::BaseController
  before_action :set_timeslot, only: [:edit, :update, :destroy]

  # GET /admin/timeslots
  def index
    @timeslots = Timeslot.all.order(:start_time)
  end

  # GET /admin/timeslots/new
  def new
    @timeslot = Timeslot.new
  end

  # GET /admin/timeslots/1/edit
  def edit
  end

  # POST /admin/timeslots
  def create
    @timeslot = Timeslot.new(timeslot_params)
    if @timeslot.save
      redirect_to admin_timeslots_url, notice: 'Timeslot was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/timeslots/1
  def update
    if @timeslot.update(timeslot_params)
      redirect_to admin_timeslots_url, notice: 'Timeslot was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/timeslots/1
  def destroy
    @timeslot.destroy
    redirect_to admin_timeslots_url, notice: 'Timeslot was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeslot
      @timeslot = Timeslot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeslot_params
      params.require(:timeslot).permit(:name, :permalink, :player_start_time, :player_end_time, :start_time, :end_time)
    end
end
