require_relative 'connection'

module Chms
  class Client
    attr_writer :username, :password, :api_key

    def initialize(args)
      @username = args[:username]
      @password = args[:password]
      @api_key  = args[:api_key]
      @authenticated = false
      @connection = Connection.new(api_key: api_key)
    end

    def login
      if username && password && api_key
        connection.login(username: username, password: password)
      end
    end

    def authenticated?
      update_authentication_status
      authenticated
    end

    def payload
      connection.payload || {}
    end

    private
      attr_reader :api_key, :username, :password, :authenticated, :connection
      attr_writer :authenticated

      def update_authentication_status
        self.authenticated = false if (status_code.nil? || status_code_invalid? || errors?)
        self.authenticated = true if (status_code_valid?)
      end

      def errors?
        connection.errors?
      end

      def status_code
        connection.status_code
      end

      def status_code_invalid?
        status_code.to_i >= 400
      end

      def status_code_valid?
        status_code.to_i == 200
      end
  end
end