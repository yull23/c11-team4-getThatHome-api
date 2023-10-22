class PropertyUsersController < ApplicationController
  before_action :set_property_user, only: %i[show update destroy]
  before_action :authorize

  # GET /property_users
  def index
    result = current_user.property_users.map do |property_view_id|
      property_view(Property.find(property_view_id.property_id))
    end
    render json: result
  end

  # GET /property_users/1
  def show
    render json: @property_user
  end

  # POST /property_users
  def create
    @property_user = PropertyUser.new(property_user_params)
    @property_user.update(user_id:current_user.id)
    if @property_user.save
      render json: @property_user, status: :created
    else
      render json: @property_user.errors, status: :unprocessable_entity
    end
  end

  def listfavorites
    @favorites = PropertyUser.where(user: current_user, favorite: true)
    result = @favorites.map do |favorite|
      property_view(Property.find(favorite.property_id))
      end
    Rails.logger.debug @favorites
    if result != []
      render json: result
    else 
      render json: { error: "No hay favoritos" }, status: :not_found
    end
  end

  def listcontacts
 
    @contacted = PropertyUser.where(user: current_user, contacted: true)
    result = @contacted.map do |contact|
      property_view(Property.find(contact.property_id))
    end
    Rails.logger.debug @contacted
    if result != []
      render json: result
    else 
      render json: { error: "No hay Contactos" }, status: :not_found
    end
  end

  # PATCH/PUT /property_users/1
  def update
    property_user= PropertyUser.find_by(user:current_user,property:set_property_user)
    property_user.update(property_user_params)
    render json: property_user
      rescue ActiveRecord::RecordNotFound
      render json: @property_user.errors, status: :unprocessable_entity
  end

  # DELETE /property_users/1
  def destroy
    @property_user.destroy
  end


  def update_my_property
    property = Property.find(property_user_params[:property_id])
    property.active = !property.active
    property.save
    render json: property
    rescue ActiveRecord::RecordNotFound
    render json: { error: "Propiedad no encontrada" }, status: :not_found
  end

  def my_properties
    all_my_properties = Property.where(user_id:current_user.id).map do |property|
      property_view(property)
    end
    render json: all_my_properties
  end

  private

  def property_view(property_found)
    {
      property: property_found,
      property_type: PropertyType.find_by(property: property_found),
      property_address: PropertyAddress.find_by(property: property_found)
    }
  end

  def set_property_user
    @property_user = PropertyUser.find(params[:id])
  end

  def property_user_params
    params.require(:property_user).permit(:property_id, :favorite, :contacted)
  end
end
