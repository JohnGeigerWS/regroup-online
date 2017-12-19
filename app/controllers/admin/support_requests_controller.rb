class Admin::SupportRequestsController < Admin::BaseController
  before_action :set_support_request, only: [:show, :edit, :update, :destroy]

  # GET /admin/support_requests
  def index
    @support_requests = SupportRequest.all.order('created_at DESC')
  end

  # GET /admin/support_requests/1
  def show
  end

  # GET /admin/support_requests/new
  def new
    @support_request = SupportRequest.new
  end

  # GET /admin/support_requests/1/edit
  def edit
  end

  # POST /admin/support_requests
  def create
    @support_request = SupportRequest.new(support_request_params)

    if @support_request.save
      redirect_to admin_support_requests_path, notice: 'Support request was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/support_requests/1
  def update
    if @support_request.update(support_request_params)
      redirect_to admin_support_requests_path, notice: 'Support request was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/support_requests/1
  def destroy
    @support_request.destroy
    redirect_to admin_support_requests_url, notice: 'Support request was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_support_request
      @support_request = SupportRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def support_request_params
      params.require(:support_request).permit(:email, :name, :subject, :message, :notes, :completed)
    end
end
