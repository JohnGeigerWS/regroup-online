module OmniAuth
  module Strategies
    autoload :Chms, Rails.root.join('lib', 'omniauth', 'strategies', 'chms')
  end
end

OmniAuth.config.logger = Rails.logger

# By default OmniAuth raises an error in development. This turns that off
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :chms, ENV["CHMS_AUTH_API_KEY"], form: StaffTicketsController.action(:new)
end
