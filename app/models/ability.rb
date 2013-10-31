class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can(:manage, User) {|u| user.id == u.id}
    end
  end
end
