class Admin::CommunicatorsController < Admin::BaseController
  before_action :set_communicator, only: [:edit, :update, :destroy]

  # GET /admin/communicators
  def index
    @communicators = Communicator.order(:name)
  end

  # GET /admin/communicators/new
  def new
    @communicator = Communicator.new
  end

  # GET /admin/communicators/1/edit
  def edit
  end

  # POST /admin/communicators
  def create
    @communicator = Communicator.new(communicator_params)

    if @communicator.save
      redirect_to admin_communicators_url, notice: 'Communicator was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/communicators/1
  def update
    if @communicator.update(communicator_params)
      redirect_to admin_communicators_url, notice: 'Communicator was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/communicators/1
  def destroy
    @communicator.destroy
    redirect_to admin_communicators_url, notice: 'Communicator was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_communicator
      @communicator = Communicator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def communicator_params
      params.require(:communicator).permit(:name)
    end
end
