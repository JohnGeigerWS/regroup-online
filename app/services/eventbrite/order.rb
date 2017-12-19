module Eventbrite
  class Order
    # Transform Eventbrite API request into Order

    attr_reader :errors

    def initialize
      self.errors = []
    end

    def process(args)
      configure_instance_properties args
      create_order if get_from_api
    end

    private
      attr_writer :errors
      attr_accessor :api_url, :order_data

      def configure_instance_properties(args)
        self.api_url = args[:api_url]
      end

      def get_from_api
        req = Request.new({ api_url: api_url, query_params: { expand: "attendees" }})

        if req.get
          self.order_data = req.resp
          return true
        end

        self.errors << "Unable to connect to Eventbrite API"
        return false
      end

      def transformed_order_data
        {
          first_name: order_data["first_name"],
          last_name: order_data["last_name"],
          email: order_data["email"],
          org_name: org_name,
          ticket_count: ticket_count
        }
      end

      def create_order
        ::Order.new.process( transformed_order_data )
      end

      def ticket_count
        # this behavior should be in the eventbrite class since the order ticket count is a fixed number.
        # We process implying the order information is a ticket

        incoming_count = order_data["attendees"].length
        return incoming_count if user_already_exists? # add more tickets to existing order
        return incoming_count - 1 # initial signup should deduct a ticket for main user account being created
      end

      def user_already_exists?
        User.exists?(email: order_data["email"])
      end

      def org_name
        # company name will only be present from within each attendee,
        # but we only actually care about the info for the first attendee
        # because they are all the same

        return "" unless order_data["attendees"].present?
        return "" if order_data["attendees"].length == 0

        return order_data["attendees"][0]["profile"]["company"] || ""
      end
  end
end
