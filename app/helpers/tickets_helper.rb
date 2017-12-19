module TicketsHelper

  def ticket_status(ticket)
    return "Complete" if ticket.invitation_accepted?
    return "Pending"
  end
end
