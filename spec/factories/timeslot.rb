FactoryGirl.define do
  factory :timeslot do
    name "Fake Timeslot"
    permalink "fake_timeslot"
    player_start_time { Time.now - 31.minutes }
    start_time { Time.now - 30.minutes }
    end_time { Time.now + 30.minutes }
    player_end_time { Time.now - 31.minutes }
  end
end
