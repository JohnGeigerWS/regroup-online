class SessionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "sessions-#{params[:session]}:updates"
  end

  def receive(data)
    logger.debug(data)
  end
end