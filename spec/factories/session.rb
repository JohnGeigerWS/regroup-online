FactoryGirl.define do
  factory :session do
    title "Fake Session Title"
    description "Fake session description."
    permalink "Fake Permalink"
    association :timeslot, :factory => :timeslot
    finished_at nil
  end
end
