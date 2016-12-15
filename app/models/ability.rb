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
    can [:index, :show, :accept, :reject, :pay], Client
    can [:index, :new, :create, :show, :pay], Doctor
    can [:index, :show, :in_pool, :not_in_pool, :send_to_pool], MedicalSituation
    can [:show, :set_fee], MedicalService
  end

  def client(user)
    can [:index,:show,:edit,:update], Client, :id => user.client.id
    can [:read, :new_medical_history,:create,
         :familyHistories, :create_familyHistory, :delete_familyHistory,
         :allergies, :create_allergy, :delete_allergy,
         :diseases, :create_disease, :delete_disease,
         ], Patient do |patient|
      any_patient?(user.client, patient.id)
    end
    can [:create, :send_to_doctor, :load_more], MedicalSituation
    can [:show], MedicalSituation do |medical_situation|
      user.client.patients.any? { |p| p.id == medical_situation.patient_id }
    end
    can [:create], Patient
    can [:create], MedicalService

    # todo: client can only update medical service that belongs to him
    can [:update], MedicalService

    # todo: client can only see services he created
    can [:show], MedicalService
  end

  def patient(user)

  end

  def doctor(user)
    can [:show, :take, :submit_report, :send_to_patient, :drop], MedicalSituation
    can [:index], Pool
    # doctor can only see his profile or edit it.
    can [:show], Doctor
    can [:update, :update_resume], Doctor, :id => user.doctor.id

    can [:show], MedicalService
    # do |medical_situation|
    #   user.doctor.medical_situations.any? { |p| p.doctor_id == medical_situation.id }
    # end

  end

  # helper methods

  # patient that belongs to authorized client user
  def any_patient?(client, id)
    client.patients.any? {|p| p.id == id }
  end

  # medical situation that belongs to the patient of authorized client
  # def any_medical_situation?(doctor,id)
  #
  # end

end
