module Chms
  class Connection 

    def initialize(args)
      @api_key = args[:api_key]
      @connection = Faraday.new(:url => 'http://npmstaff.org/account/wsapi/') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        # faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def login(args)
      self.response = connection.post 'login', { 'u' => args[:username], 
                                                 'p' => args[:password], 
                                                 'API-KEY' => api_key }
    end

    def errors?
      parsed_payload.key? 'errors'
    end

    def errors
      parsed_payload["error"] if errors?
    end

    def status_code
      return nil unless response.respond_to? 'status'
      response.status
    end

    def payload
      parsed_payload
    end

    private
      attr_reader :connection, :api_key
      attr_accessor :response

      def parsed_payload
        return JSON::parse(response.body) unless response.nil?
      end
  end
end