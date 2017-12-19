class AddPlayerStartTimeToTimeslots < ActiveRecord::Migration[5.0]
  def change
    add_column :timeslots, :player_start_time, :timestamp
  end
end
