class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
  def index?
    user.admin?
  end

  def show?
    user.admin? || user == record
  end

  def update?
   user.admin?
  end

  def destroy?
    return false if record == user
    user.admin?
  end

end
