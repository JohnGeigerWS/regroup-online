class SessionPresenter

  def initialize(session = Session.new)
    @session = session
  end

  def title
    session.title
  end

  def channel_id
    session.channel_id
  end

  def poll_url
    Rails.application.routes.url_helpers.check_drive_session_path(session, format: :json)
  end

  def live?
    session.live?
  end

  def player_started?
    session.player_started?
  end

  def finished?
    session.finished?
  end

  def description
    session.description
  end

  def pdf
    return Asset.new unless assets
    assets.pdf.first
  end

  def communicators
    return "" unless session.communicators
    session.communicators.map(&:name).to_sentence(two_words_connector: ' & ', last_word_connector: " & ")
  end

  def live_embed
    assets.haivision_live_embed.first.value if session.live_embed?
  end

  def vod_embed
    assets.haivision_vod_embed.first.value if session.vod_embed?
  end

  def active_embed
    return vod_embed if vod_available?

    return live_embed if (live_available? && player_started? && !finished?)

    ""
  end

  def player_available?
    active_embed != ""
  end

  def live_available?
    session.live_embed?
  end

  def vod_available?
    session.vod_embed?
  end

  def time_until_start
    session.timeslot.player_start_time - Time.now
  end

  def time_until_end
    session.timeslot.player_end_time - Time.now
  end

  def serialized
    h = {
      title: title,
      description: description,
      pdf: pdf,
      communicators: communicators,
      live_embed: live_embed,
      vod_embed: vod_embed,
      active_embed: active_embed,
      time_until_start: time_until_start,
      time_until_end: time_until_end,
      is_live: live?,
      is_finished: finished?
    }

    h.to_json
  end

  private
    attr_reader :session

    def assets
      session.assets
    end
end
