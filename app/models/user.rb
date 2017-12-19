class User < ApplicationRecord
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  attr_accessor :skip_invitation

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def purchased_tickets
    current_user_ticket = invited? ? 0 : 1 # if you were invited then your ticket was purchased by someone else
    return current_user_ticket + additional_tickets
  end

  def additional_tickets?
    additional_tickets > 0
  end

  def additional_tickets
    invitation_limit + invitations_count
  end

  def remaining_tickets
    invitation_limit
  end

  def invited?
    invited_by.nil? ? false : true
  end
end
