require 'rails_helper'

RSpec.describe Timeslot, type: :model do
  describe "#current" do
    context "one timeslot exists in the db" do
      it 'returns the timeslot if current time is player start time' do
        now = Time.now
        timeslot = create(:timeslot, player_start_time: now, end_time: now + 1.hour)
        current  = Timeslot.live

        expect( current.id ).to eq timeslot.id
      end

      it 'returns the timeslot if current time is 1 second before end time' do
        now = Time.now
        timeslot = create(:timeslot, player_start_time: now - 1.hour, end_time: now + 1.second)
        current  = Timeslot.live

        expect( current.id ).to eq timeslot.id
      end

      it 'does not return the timeslot if current time is 1 second before player start time' do
        now = Time.now
        timeslot = create(:timeslot, player_start_time: now + 1.second, end_time: now + 1.hour)
        current  = Timeslot.live

        expect( current ).to be_nil
      end

      it 'does not return the timeslot if current time is 1 second after end time' do
        now = Time.now
        timeslot = create(:timeslot, player_start_time: now - 1.hour, end_time: now - 1.second)
        current  = Timeslot.live

        expect( current ).to be_nil
      end
    end
  end

  describe "#next" do
    context "one timeslot exists in the db" do
      it "returns the timeslot when it is upcoming" do
        now = Time.now
        future_timeslot = create(:timeslot, player_start_time: now + 1.second) # :end_time is 30 mins from now
        expect(Timeslot.next.id).to eq(future_timeslot.id)
      end

      it "returns nil when it is occurring" do
        now = Time.now
        current_timeslot = create(:timeslot)
        expect(Timeslot.next).to be_nil
      end

      it "returns nil after it has occurred" do
        now = Time.now
        past_timeslot = create(:timeslot, end_time: now - 1.second)
        expect(Timeslot.next).to be_nil
      end
    end

    context "multiple timeslots exists in the db" do
      it "returns the first timeslot if current time is before the earliest player start time" do
        now = Time.now
        future_timeslot_1 = create(:timeslot, player_start_time: now + 1.second, end_time: now + 5.seconds)
        future_timeslot_2 = create(:timeslot, player_start_time: now + 10.second, end_time: now + 15.seconds)

        expect(Timeslot.next.id).to eq(future_timeslot_1.id)
      end

      it "returns the upcoming timeslot during an live timeslot" do
        now = Time.now
        current_timeslot = create(:timeslot, player_start_time: now - 1.second, end_time: now + 1.second)
        future_timeslot = create(:timeslot, player_start_time: now + 3.seconds, end_time: now + 5.seconds)

        expect(Timeslot.next.id).to eq(future_timeslot.id)
      end
    end
  end
end
