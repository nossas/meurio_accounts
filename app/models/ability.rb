class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can(:manage, User) {|u| user.id == u.id}
      if user.admin?
        can(:manage, User)
      end
    end
  end
end
