class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      user.roles.each { |role| send(role.name.downcase, user) }
  end

  # write down role permissions here
  def admin(user)

  end

  def manager(user)
    can :manage, Manager
    can [:read, :create], CallBack
    can [:accept], Client
  end

  def client(user)
    can :manage, Client, :id => user.client.id
    can [:read, :new_medical_history,:create_medical_history, :allergies,
        :create_allergy, :delete_allergy], Patient do |patient|
      any_patient?(user.client, patient.id)
    end
    can [:create], [Patient]
  end

  def patient(user)

  end

  def doctor(user)

  end

  # helper methods

  def any_patient?(client, id)
    client.patients.any? {|p| p.id == id }
  end


end
