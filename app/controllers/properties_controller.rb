class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action  :authorize, only: %i[create destroy update]
  # skip_before_action
  # GET /properties
  def index
    @properties = Property.where(active: true)
    render json: @properties
  end

  # GET /properties/1
  def show
    if @property
      render json: {
        id: @property,
        latitude: @property.property_address.latitude,
        longitude: @property.property_address.longitude,
      }
    else
      render json: { error: "Propiedad no encontrada" }, status: :not_found
    end
  end

 # POST /properties
  def create
    address = PropertyAddress.new(name: params[:address][:name],latitude: params[:address][:latitude],
      longitude: params[:address][:longitude])

    unless address.save
      render json: { error: 'Error al crear la dirección de la propiedad' }, status: :unprocessable_entity
      return
    end

    photos = params[:photo_url]
    data_keys = %i[bedrooms bathrooms area description active property_type_id price monthly_rent maintenance pets_allowed operation]
    other_data = property_params.slice(*data_keys).merge(photo_url: photos, property_address: address )

    @property = Property.new(other_data)
    p @property
    if @property.save
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  
  def update
    address = PropertyAddress.find_by(id: @property.property_address_id)
    address.update(name: params.dig(:address, :name)) if params.dig(:address, :name).present?

    photos = params[:photo_url]
    data_keys = %i[bedrooms bathrooms area description active property_type_id]
    other_data = property_params.slice(*data_keys)

    body = photos.present? ? other_data.merge(photo_url: photos) : other_data
    if @property.update(body)
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    render json: { message: "Propiedad eliminada con éxito" }
  end

  def listBestPrice
    @properties = Property.where(active: true, operation: "Rent")
    @properties = @properties.order(price: :ASC)
    render json: @properties
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.permit(
      :bedrooms, :bathrooms, :area, :description, :active, :property_type_id, :pets_allowed, photo_url: [], 
      address: [:name, :latitude, :longitude]
    )
  end
  

end
