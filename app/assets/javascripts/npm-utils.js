var NPM = {};

NPM.utils = {
  delay: function(callback, seconds) {
    setTimeout(callback, seconds * 1000);
  },
  pluralize: function(string, count) {
    if (count == 1) {
      return string;
    }
    return string + 's';
  },
  prettyCountdownTime: function(event) {
    var formatted = '',
        offset = event.offset;

    // So far out just give days
    var totalDays = (offset.weeks * 7) + offset.days
    if (totalDays > 0) return totalDays + ' ' + NPM.utils.pluralize('Day', totalDays);

    // Day of event formatting
    // Hours and minutes remaining
    if (offset.hours > 0) {
      formatted = offset.hours + ' ' + NPM.utils.pluralize('Hour', offset.hours);
      if (offset.minutes > 0) formatted += ' and ' + offset.minutes + ' ' + NPM.utils.pluralize('Minute', offset.minutes);
      return formatted
    }

    // Only minutes remaining
    if (offset.minutes > 0) {
      var displayMinutes = offset.minutes + 1; // Since seconds are discarded
      return displayMinutes + ' ' + NPM.utils.pluralize('Minute', displayMinutes);
    }

    // Only seconds remaining
    return offset.seconds + ' ' + NPM.utils.pluralize('Second', offset.seconds);
  },
  countdown: function(el, liveState) {
    var nextTimeslot = +(new Date(liveState.next.timeslot.player_start_time)) / 1000,
        now = +(new Date(liveState.currentTime)) / 1000,
        secsTil = nextTimeslot - now,
        jsDate = new Date(new Date().valueOf() + secsTil * 1000 );

    $(el).countdown(jsDate, function(event) {
      var html = '<h4>'+ liveState.next.timeslot.name +' starts in</h4> <h4>'+ NPM.utils.prettyCountdownTime(event) +'</h4>';
      $(this).html(html);
    }).on('finish.countdown', function(event) {
      var html = '<h4>'+ liveState.next.timeslot.name +' is:</h4> <h4>ON AIR!</h4>';
      $(this).html(html);
    });
  },
  secondsBetweenTimestamps: function(start, end) {
    var startDate = +( new Date(start) );
    var endDate   = +( new Date(end) );

    return (endDate - startDate) / 1000;
  }
};
