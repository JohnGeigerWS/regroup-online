#######################################################################################################################
# CLEAN UP TABLES

Communicator.delete_all
Session.delete_all
Timeslot.delete_all

#######################################################################################################################
# BUILD THE TIMESLOTS AND SESSIONS
timeslots = JSON.parse(File.read "#{Rails.root}/db/timeslots.json")

timeslots.each do |timeslot|
  sessions = timeslot['sessions']
  timeslot.delete('sessions')
  t = Timeslot.create(timeslot)
  t.sessions.create(sessions)
end


#######################################################################################################################
# BUILD THE COMMUNICATORS
communicators = ["Andy Stanley", "Clay Scroggins", "Rick Holliday", "Dave Adamson", "Chris Ames", "Lane Jones", "Tom Shefchunas", "Bill Willits", "Lauren Espy", "John Woodall", "Jeff Henderson", "Billy Phenix", "Adam Johnson", "Kendra Fleming", "Gina Ragsdale", "Amy Walker", "Holly Goddard", "Joel Thomas", "Dan Stonaker", "Tim Cooper", "Justin Elam", "Gavin Adams"]
communicators.each { |name| Communicator.create(name: name) }
