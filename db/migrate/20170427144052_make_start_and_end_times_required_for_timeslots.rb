class MakeStartAndEndTimesRequiredForTimeslots < ActiveRecord::Migration[5.0]
  def change
    change_column_null :timeslots, :start_time, false
    change_column_null :timeslots, :end_time, false
    change_column_null :timeslots, :player_start_time, false
    change_column_null :timeslots, :player_end_time, false
  end
end
