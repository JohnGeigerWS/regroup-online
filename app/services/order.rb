# TODO: rename to OrderProcessor? OrderCreator? OrderDirector? OrderDictator? OrderCzar?
class Order
  # Process an order from any incoming source
  # Processing is gather attributes and store them

  attr_reader :email, :first_name, :last_name, :ticket_count, :org_name

  def process(params)
    abstract_params(params)
    process_user
  end

  private
    attr_writer :email, :first_name, :last_name, :ticket_count, :org_name

    def abstract_params(params)
      self.email        = params[:email]
      self.first_name   = params[:first_name]
      self.last_name    = params[:last_name]
      self.ticket_count = params[:ticket_count]
      self.org_name     = params[:org_name]
    end

    def process_user
      return update_ticket_count if user_exists_by_email?
      save_user
    end

    def update_ticket_count
      u = User.find_by_email(email)
      u.invitation_limit += ticket_count
      u.save
      send_order_updated_email(u)
    end

    def save_user
      User.create!(user_params)
    end

    def user_exists_by_email?
      User.exists?(email: email)
    end

    def user_params
      # TODO: invitable public methods
      {
        invitation_limit: ticket_count,
        email: email,
        first_name: first_name,
        last_name: last_name,
        org_name: org_name,
        password: temp_password
      }
    end

    def temp_password
      Devise.friendly_token.first(8)
    end

    def send_order_updated_email(user)
      OrderMailer.order_updated_email(user).deliver_later
    end
end
