class PropertyUserController < ApplicationController
  before_action :authenticate_user!
  before_action :require_homeseeker_role, only: %i[index create update]

  def index
    @saved_properties = SavedProperty.where(user: current_user)
    render json: @saved_properties
  end

  def create
    property = Property.find_by(id: params[:property_id])
    @saved_property = SavedProperty.new(property:, user: current_user)

    if @saved_property.save
      render json: @saved_property, status: :ok
    else
      render json: @saved_property.errors, status: :unprocessable_entity
    end
  end

  def update
    @saved_property = SavedProperty.find_by(user: current_user, id: params[:id])

    if @saved_property.update(saved_properties_params)
      render status: :ok
    else
      render json: @saved_property.errors, status: :unprocessable_entity
    end
  end

  private

  def require_homeseeker_role
    return if current_user.role_name == "Homeseeker"

    render status: :unprocessable_entity,
           json: { error: "Acceso denegado. Se requiere el rol de Homeseeker." }
  end

  def saved_properties_params
    params.permit(:favorite, :contacted)
  end
end
