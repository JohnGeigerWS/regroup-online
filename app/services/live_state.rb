class LiveState
# Acts as a data object to represent the state of live feeds

  def self.get_current_state
    now = Time.now
    live_timeslot = Timeslot.live(now)
    next_timeslot = Timeslot.next(now)    

    {
      isLive: live_timeslot.present?,
      hasUpcoming: next_timeslot.present?,
      isDone: live_timeslot.nil? && next_timeslot.nil?,
      live: self.serialize_timeslot(live_timeslot),
      next: self.serialize_timeslot(next_timeslot),
      currentTime: now
    }
  end

  private

    # TODO: Refactor into serializer
    def self.serialize_timeslot timeslot
      return {} if timeslot.nil?

      timeslot_hash = {}
      timeslot_hash[:timeslot] = timeslot.as_json
      timeslot_hash[:timeslot][:days_until] = (timeslot.start_time - Time.now) / (60 * 60 * 24)
      timeslot_hash[:timeslot][:sessions] = timeslot.sessions.inject([]) do |collection, session|
        session_hash = session.as_json
        session_hash[:assets] = session.assets.inject({}) do |collection, asset|
          collection[ asset.kind.to_sym ] = asset.as_json
          collection
        end
        collection << session_hash
        collection
      end

      timeslot_hash
    end
end
