class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         # :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Allows the model to exchange messages with other users
  acts_as_messageable

  has_many :assignments
  has_many :roles, through: :assignments

  # check if user is assigned to the given role
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end


  #Returning the email address of the model if an email should be sent for this object (Message or Notification).
  #If no mail has to be sent, return nil.
  def mailboxer_email(object)
    email
  end


end
