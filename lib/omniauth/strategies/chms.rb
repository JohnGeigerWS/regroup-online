require_relative 'chms/client'

module OmniAuth
  module Strategies
    class Chms
      include OmniAuth::Strategy

      # Sets up the args from the initializer. In order of comma seperation.
      args [:api_key]

      # fields to loop through for the info section of the response
      option :fields, [ 'id', 
                        'firstName', 
                        'lastName', 
                        'nickName', 
                        'username', 
                        'email', 
                        'sessionId', 
                        'myaccount_cookie' ]

      def callback_phase
        submit_credentials
        # We will catch a missing response and any failures deemed from the connection
        return fail!(:invalid_credentials) unless @client
        return fail!(:invalid_credentials) unless @client.authenticated?
        
        # All must be well. Proceed and build Schema response.
        super
      end
      
      uid do
        response_data['id']
      end

      info do
        options.fields.inject({}) do |hash, field|
          hash[field] = response_data[field]
          hash
        end
      end

      private 
        attr_reader :client

      protected

        def api_key
          options.api_key
        end

        def username
          request['username']
        end

        def password
          request['password']
        end

        def submit_credentials
          log('warn', "Making CHMS authentication attempt")

          return unless username && password
          @client = ::Chms::Client.new({ api_key: api_key, username: username, password: password })
          @client.login
        end

        def response_data
          @response_data ||= @client.payload
        end
    end
  end
end