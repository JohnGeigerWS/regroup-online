class Asset < ApplicationRecord
  enum kind: [:haivision_live_embed, :haivision_vod_embed, :pdf]
  belongs_to :session

  validates :kind, presence: true
end
