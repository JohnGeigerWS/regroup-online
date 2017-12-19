class Presenter < ApplicationRecord
  belongs_to :communicator
  belongs_to :session
end
