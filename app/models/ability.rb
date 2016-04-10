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
    can [:accept, :reject], Client
    can [:index, :new, :create, :show], Doctor
  end

  def client(user)
    can :manage, Client, :id => user.client.id
    can [:read, :new_medical_history,:create_medical_situation,
         :familyHistories, :create_familyHistory, :delete_familyHistory,
         :allergies, :create_allergy, :delete_allergy,
         :diseases, :create_disease, :delete_disease,
          :load_more], Patient do |patient|
      any_patient?(user.client, patient.id)
    end
    can [:create], [Patient]
  end

  def patient(user)

  end

  def doctor(user)
    can :manage, Doctor, :id => user.doctor.id
  end

  # helper methods
  def any_patient?(client, id)
    client.patients.any? {|p| p.id == id }
  end


end
