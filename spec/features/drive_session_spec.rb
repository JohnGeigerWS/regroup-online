require 'rails_helper'

feature "Navigating to a session" do
  background do
    create(:user)
    create(:session) # additional session for multiples in db

    visit root_path
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'password'
    click_button 'LOG IN'
  end

  describe "displaying proper session information" do
    it "shows the session title" do
      session = create(:session, title: "New Fake Session Title")
      visit drive_session_path(session)
      expect(page).to have_content("New Fake Session Title")
    end

    it "shows the session description" do
      session = create(:session, description: "New faker session description.")
      visit drive_session_path(session)
      expect(page).to have_content("New faker session description.")
    end

    context "with a pdf asset" do
      it "has a pdf link" do
        session = create(:session)
        session.assets.create(kind: 'pdf', name: "New Fake PDF Name", label: "New Fake PDF Label", value: "http://www.fake_url.com/new_fake.pdf")
        visit drive_session_path(session)
        expect(page).to have_link("New Fake PDF Label")
      end
    end

    context "without a pdf asset" do
      it "doesn't have a pdf link" do
        session = create(:session)
        visit drive_session_path(session)
        expect(page).not_to have_link("New Fake PDF Label")
      end
    end
  end
end

feature 'Navigating to a session before player start time' do
  background do
    create(:user)
    timeslot = create(:timeslot, player_start_time: Time.now + 1.minute,
                                 start_time: Time.now + 2.minutes,
                                 end_time: Time.now + 3.minutes)
    session  = create(:session, timeslot: timeslot)

    visit root_path
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'password'
    click_button 'LOG IN'

    visit drive_session_path(session)
  end

  it 'shows the slideshow' do
    expect(page).to have_css('#slideshow-container')
  end
  it 'hides the player container' do
    expect(page).to have_css('#player-container.hide')
  end
  it 'has an empty player container' do
    expect(find('#player')).to have_content("")
  end
end

feature 'Navigating to a session during a live session timeframe' do
  background do
    create(:user)
    timeslot = create(:timeslot, end_time: Time.now + 5.seconds,
                                 player_end_time: Time.now + 10.seconds)
    @session = create(:session, timeslot: timeslot)
    @session.assets.create(kind: 'haivision_live_embed', name: "Fake Live Embed", label: "Fake Live Embed Label", value: "fake_live_embed")

    visit root_path
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'password'
    click_button 'LOG IN'

    visit drive_session_path(@session)
  end

  it 'hides the slideshow' do
    expect(page).to have_css('#slideshow-container.hide')
  end
  it 'shows the player container' do
    expect(page).to have_css('#player-container')
    expect(page).not_to have_css('#player-container.hide')
  end
  it 'has the session live embed in the player container' do
    expect(find('#player')).to have_content(@session.assets.haivision_live_embed.first.value)
  end

  it 'hides the player container when session is finished'
  it 'shows the slideshow when session is finished'
end

feature 'Navigating to a session after session is finished' do
  background do
    create(:user)
    @finished_session = create(:session, finished_at: Time.now - 1.minute)
    @finished_session.assets.create(kind: 'haivision_live_embed', name: "Fake Live Embed", label: "Fake Live Embed Label", value: "fake_live_embed")

    visit root_path
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'password'
    click_button 'LOG IN'
  end

  context 'has VOD' do
    background do
      @finished_session.assets.create(kind: 'haivision_vod_embed', name: "Fake VOD Embed", label: "Fake VOD Embed Label", value: "fake_vod_embed")
      visit drive_session_path(@finished_session)
    end

    it 'hides the slideshow' do
      expect(page).to have_css('#slideshow-container.hide')
    end
    it 'shows the player container' do
      expect(page).to     have_css('#player-container')
      expect(page).not_to have_css('#player-container.hide')
    end
    it 'has the session VOD embed in the player container' do
      expect(find('#player')).to have_content(@finished_session.assets.haivision_vod_embed.first.value)
    end
  end

  context 'does not have VOD' do
    background do
      visit drive_session_path(@finished_session)
    end

    it 'shows the slideshow' do
      expect(page).not_to have_css('#slideshow-container.hide')
    end
    it 'hides the player container' do
      expect(page).to have_css('#player-container.hide')
    end
    it 'has an empty player container' do
      expect(find('#player')).to have_content('')
    end
  end
end