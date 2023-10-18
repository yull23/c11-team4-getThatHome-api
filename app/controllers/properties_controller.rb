class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  skip_before_action :authorize, only: %i[destroy update]

  # GET /properties
  def index
    @properties = Property.where(active: true)
    render json: @properties
  end

  # GET /properties/1
  def show
    if @property
      render json: @property
    else
      render json: { error: 'Propiedad no encontrada' }, status: :not_found
    end
  end

  def create
    address = PropertyAddress.new(name: params[:address][:name])
    unless address.save
      render json: { error: 'Error al crear la dirección de la propiedad' }, status: :unprocessable_entity
      return
    end

    photos = params[:photo_url]
    other_data_keys = %i[bedrooms bathrooms area description active property_type_id]
    other_data = property_params.slice(*other_data_keys).merge(photo_url: photos, property_address: address)

    @property = Property.new(other_data)
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
    render json: { message: 'Propiedad eliminada con éxito' }
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
    params.permit(:bedrooms, :bathrooms, :area, :description, :active, :property_type_id, :property_address_id, :photo_url)
  end
end
