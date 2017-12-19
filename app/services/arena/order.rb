module Arena
  class Order

    def process(args)
      self.order_data = args
      create_order unless order_placed?
    end

    private

      attr_accessor :order_data

      def transformed_order_data
        temp_data = order_data.clone
        temp_data[:ticket_count] = 1
        temp_data
      end

      def order_placed?
        User.exists? email: order_data[:email]
      end

      def create_order
        ::Order.new.process( transformed_order_data )
      end
  end
end
