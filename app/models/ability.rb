class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      user.roles.each { |role| send(role.name.downcase) }
  end

  # write down role permissions here
  def admin

  end

  def manager
    can :read, CallBack
  end

  def client
    can :manage, :all
  end

  def patient

  end

  def doctor

  end

end
