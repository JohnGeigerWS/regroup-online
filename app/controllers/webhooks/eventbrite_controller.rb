class Webhooks::EventbriteController < ApplicationController
  protect_from_forgery except: :order_placed

  def order_placed
    logger.debug("===== Eventbrite Webhook Payload =====\n#{params.inspect}")
    hashed_params = params.permit!.to_h
    CreateEventbriteOrderJob.perform_later(hashed_params)

    head :ok
  end
end
