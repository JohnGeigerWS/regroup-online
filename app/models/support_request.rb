class SupportRequest < ApplicationRecord
  validates_presence_of :email, :name, :subject, :message
end
