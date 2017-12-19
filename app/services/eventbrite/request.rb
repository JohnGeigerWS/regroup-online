module Eventbrite
  class Request

    attr_reader :resp

    def initialize(args)
      self.api_url = args[:api_url]
      self.query_params = args[:query_params]
    end

    def get
      resp = conn.get do |req|
        req.params['token'] = ENV['EVENTBRITE_API_TOKEN']
        query_params.each { |param, value| req.params[param] = value }
      end

      return false if resp.body.empty?

      self.resp = JSON.parse(resp.body)
      return true
    end

    private
      attr_accessor :api_url, :query_params
      attr_writer :resp

      def conn
        Faraday.new(:url => api_url) do |faraday|
          faraday.response :logger                  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end
  end
end
