class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /admin/users
  def index
    @users = User.where.not(id: current_user.id).order(:last_name, :first_name)
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      redirect_to admin_users_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end

  def resend_confirmation
    @user = User.find(params[:user_id])
    @user.send_confirmation_instructions
    redirect_to :back, notice: 'Confirmation email sent to user.'
  end

  def send_reset_password
    @user = User.find(params[:user_id])
    @user.send_reset_password_instructions
    redirect_to :back, notice: 'Password reset email sent to user.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :admin_role, :org_name, :password, :password_confirmation)
    end
end
