class AddFinishedAtToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :finished_at, :timestamp
  end
end
