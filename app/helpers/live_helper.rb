module LiveHelper
  def format_time_window(timeslot)
    "#{timeslot.start_time.strftime("%-l:%M%P")}&nbsp;&ndash;&nbsp;#{timeslot.end_time.strftime("%-l:%M%P")}".html_safe
  end

  def vod_exists?(session)
    session.assets.any? { |asset| asset.haivision_vod_embed? }
  end

  def session_button_markup(session)
    button_label = session_button_label(session)

    if session.vod_pending?
      return button_tag button_label, class: 'button small left live expanded disabled'
    end

    link_to button_label, drive_session_path(session), class: "button small left live expanded"
  end

  def session_button_label(session)
    return 'On Demand Coming Soon' if session.vod_pending?
    return 'Watch On Demand' if session.vod_embed?
    return 'Join Session'
  end
end
