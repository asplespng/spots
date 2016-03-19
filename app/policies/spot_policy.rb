class SpotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def permitted_attributes
    attribs = [:latitude, :longitude, :radius, :address_1, :address_2, :city, :state, :zip, :use_address, :name]
    if user.admin?
      attribs << :user_id
    end
    attribs
  end
end