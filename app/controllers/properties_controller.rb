class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :authorize, only: %i[create destroy update]
  # skip_before_action
  # GET /properties
  def index
    @properties = Property.where(active: true)
    all_properties = @properties.map do |index_property|
      get_property_view(index_property)
    end
    render json: all_properties
  end

  # GET /properties/1
  def show
    if @property

      render json: get_property_view(@property)
    else
      render json: { error: "Propiedad no encontrada" }, status: :not_found
    end
  end

  # POST /properties
  def create
    address = PropertyAddress.new(name: params[:address][:name], latitude: params[:address][:latitude],
                                  longitude: params[:address][:longitude])

    unless address.save
      render json: { error: "Error al crear la dirección de la propiedad" },
             status: :unprocessable_entity
      return
    end
    # Update

    photos = params[:photo_url]
    data_keys = %i[bedrooms bathrooms area description active property_type_id price monthly_rent
                   maintenance pets_allowed operation t_phone t_email]
    other_data = property_params.slice(*data_keys).merge(photo_url: photos,
                                                         property_address: address)

    @property = Property.new(other_data)
    p @property
    if @property.save
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update
    @property = set_property
    if current_user.id == @property.user_id
      address = PropertyAddress.find(@property.property_address_id)
      type_property = PropertyType.find(@property.property_type_id)
      @property.update(data_property)
      address.update(data_property_addres)
      type_property.update(data_property_type)
      render json: { message: "Propiedad actualizada con éxito" }
    else
      render json: @property.errors, status: :unprocessable_entity
    end

  end

  def destroy
    if current_user.id == @property.user_id
      @property.destroy
      render json: { message: "Propiedad eliminada con éxito" }
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def listBestPrice
    @properties = Property.where(active: true, operation: "Rent")
    properties_sorted = @properties.sort_by { |propertyView| propertyView.price }
    best_property = properties_sorted[0, 3].map do |a|
      get_property_view(a)
    end
    render json: best_property
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def get_property_view(propertyFound)
    {
      property: propertyFound,
      property_type: PropertyType.find_by(property: propertyFound),
      property_address: PropertyAddress.find_by(property: propertyFound)
    }
  end

  def data_property
    {
      operation: params[:property][:operation],
      price: params[:property][:price],
      maintenance: params[:property][:maintenance],
      area: params[:property][:area],
      description: params[:property][:description],
      bedrooms: params[:property][:bedrooms],
      bathrooms: params[:property][:bathrooms],
      pets_allowed: params[:property][:pets_allowed],
      photo_url: params[:property][:photo_url],
      active: params[:property][:active]
    }
  end

  def data_property_addres
    {
      name: params[:property_address][:name],
      latitude: params[:property_address][:latitude],
      longitude: params[:property_address][:longitude]
    }
  end

  def data_property_type
    {
      name: params[:property_type][:name]
    }
  end

  def property_params
    params.permit(:id,
                  property: %i[property_type_id
                               property_address_id
                               operation
                               price
                               maintenance
                               area
                               description
                               bedrooms
                               bathrooms
                               pets_allowed
                               active],
                  property_type: %i[name],
                  property_address: %i[name latitude longitude])
  end
end
