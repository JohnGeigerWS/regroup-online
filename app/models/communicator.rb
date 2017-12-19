class Communicator < ApplicationRecord
  has_many :presenters
  has_many :sessions, through: :presenters
end
