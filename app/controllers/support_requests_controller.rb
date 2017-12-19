class SupportRequestsController < ApplicationController
  def new
    @support_request = SupportRequest.new
  end


  def create
    @support_request = SupportRequest.new(support_request_params)

    if @support_request.save
      # TODO: Move this to model after_save?
      SupportRequestMailer.support_request_created_email(@support_request).deliver_later
      
      redirect_to root_url, notice: 'Support request was successfully created.'
    else
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def support_request_params
      params.require(:support_request).permit(:email, :name, :subject, :message)
    end

end
