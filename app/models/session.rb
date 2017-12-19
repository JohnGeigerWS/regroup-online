class Session < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :assets, dependent: :destroy
  has_many :presenters, dependent: :destroy
  has_many :communicators, through: :presenters
  accepts_nested_attributes_for :presenters, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  belongs_to :timeslot

  def live?
    return false if finished?

    timeslot.player_live?
  end

  def player_started?
    timeslot.players_started?
  end

  def finished?
    finished_at.present?
  end

  def vod_embed?
    assets.any? { |asset| asset.haivision_vod_embed? }
  end

  def live_embed?
    assets.any? { |asset| asset.haivision_live_embed? }
  end

  def pdf?
    assets.any? { |asset| asset.pdf? }
  end

  def channel_id
    self.id
  end

  def vod_pending?
    self.finished? && !self.vod_embed?
  end

  def finish!
    if self.touch(:finished_at)
      ActionCable.server.broadcast("sessions-#{self.id}:updates", session: self)
      return true
    end

    false
  end

  def restart!
    self.update_attributes(finished_at: nil)
  end
end
