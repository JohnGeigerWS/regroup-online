class ConfirmationsController < Devise::ConfirmationsController

  def show

    @original_token = params[:confirmation_token]

    self.resource = resource_class.find_by_confirmation_token(@original_token) if params[:confirmation_token].present?

    super if resource.nil? or resource.confirmed?

  end

  def confirm

    @original_token = permitted_params[:confirmation_token]

    self.resource = resource_class.find_by_confirmation_token! @original_token

    resource.assign_attributes(permitted_params) # unless permitted_params[resource_name].nil?

    if resource.valid? && resource.password_match?
      self.resource.confirm
      self.resource.accept_invitation!
      set_flash_message :notice, :confirmed
      sign_in resource
      redirect_to root_url
    else
      render :action => 'show'
    end

  end

 private

   def permitted_params
     params.require(resource_name).permit(:confirmation_token, :password, :password_confirmation)
   end

end
