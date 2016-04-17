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
    can [:index, :in_pool, :not_in_pool, :send_to_pool], MedicalSituation
    can [:read, :create], CallBack
    can [:accept, :reject], Client
    can [:index, :new, :create, :show], Doctor
  end

  def client(user)
    can :manage, Client, :id => user.client.id
    can [:read, :new_medical_history,:create,
         :familyHistories, :create_familyHistory, :delete_familyHistory,
         :allergies, :create_allergy, :delete_allergy,
         :diseases, :create_disease, :delete_disease,
         ], Patient do |patient|
      any_patient?(user.client, patient.id)
    end
    can [:create, :load_more], MedicalSituation
    can [:create], [Patient]
  end

  def patient(user)

  end

  def doctor(user)
    can [:take], MedicalSituation
    can [:index], Pool
    can :manage, Doctor, :id => user.doctor.id
  end

  # helper methods

  # patient that belongs to authorized client user
  def any_patient?(client, id)
    client.patients.any? {|p| p.id == id }
  end

  # medical situation that belongs to the patient of authorized client

end
