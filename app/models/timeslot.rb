class Timeslot < ApplicationRecord
  has_many :sessions
  validates_presence_of :player_start_time, :player_end_time, :start_time, :end_time

  def self.live(now = Time.now)
    self.where("player_start_time <= ? AND end_time >= ?", now, now).first
  end

  def self.next(now = Time.now)
    self.where("player_start_time > ?", now).order(:start_time).first
  end

  def breakout?
    sessions.length > 1
  end

  def main?
    sessions.length == 1
  end

  def players_started?
    now = Time.now
    player_start_time <= now
  end

  def live?
    now = Time.now
    return start_time <= now && now <= end_time
  end

  def player_live?
    now = Time.now
    return player_start_time <= now && now <= player_end_time
  end
end
