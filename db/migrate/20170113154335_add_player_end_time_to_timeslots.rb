class AddPlayerEndTimeToTimeslots < ActiveRecord::Migration[5.0]
  def change
    add_column :timeslots, :player_end_time, :timestamp
  end
end
