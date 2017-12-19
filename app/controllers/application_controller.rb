class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # TODO: comment out these timecop methods once we go live
  # TODO: catch errors in controller actions and call Timecop.return
  before_action :get_live_state
  # before_action :freeze_time, if: :utilize_timecop?
  # after_action :return_time, if: :utilize_timecop?

  # Implemented from: https://github.com/CanCanCommunity/cancancan#3-handle-unauthorized-access
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: exception.message
  end

  private
    def get_live_state
      @live_state = LiveState.get_current_state
    end

    def utilize_timecop?
      ENV["TIMECOP_TIME"] && Rails.env.development?
    end

    def freeze_time
      Timecop.freeze( Time.parse(ENV["TIMECOP_TIME"]) )
    end

    def return_time
      Timecop.return
    end
end
