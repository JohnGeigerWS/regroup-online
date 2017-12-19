class CreateEventbriteOrderJob < ApplicationJob
  queue_as :default

  def perform(args)
    unless has_required_args(args)
      logger.debug("==== Eventbrite webhook ignored - payload incorrect ====")
      return
    end

    capture_error unless Eventbrite::Order.new.process(args)
  end

  private
    def capture_error
      logger.debug("===== Eventbrite API Failed :( =====")
    end

    def has_required_args args
      args[:api_url].present?
    end
end
