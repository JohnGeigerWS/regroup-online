class CreateTimeslots < ActiveRecord::Migration[5.0]
  def change
    create_table :timeslots do |t|
      t.string :name
      t.string :permalink
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
