class Ability
  include CanCan::Ability

  def initialize(user, request = nil)
    if user
      can(:manage, User) {|u| user.id == u.id}
      if user.admin?
        can(:manage, User)
      end
    end

    if request && request.params[:format] == "json"
      if request.params[:token] == ENV["API_TOKEN"]
        can :create, User
        can :create, Membership
      else
        cannot :create, User
        cannot :create, Membership
      end
    end
  end
end
