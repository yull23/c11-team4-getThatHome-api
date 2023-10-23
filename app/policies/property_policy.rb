class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    def create?
      user.rol_id == 1  # Permite crear propiedades solo a los propietarios
    end
  end
end
