class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :authorize, only: %i[create destroy update]
  # skip_before_action
  # GET /properties
  def index
    @properties = Property.where(active: true)
    all_properties = @properties.map do |index_property|
      property_view(index_property)
    end
    render json: all_properties
  end

  # GET /properties/1
  def show
    if @property

      render json: property_view(@property)
    else
      render json: { error: "Propiedad no encontrada" }, status: :not_found
    end
  end

  # POST /properties
  def create
    address = PropertyAddress.create(data_property_addres)
    type_property = PropertyType.find_by(name:params[:property_type][:name])
    @property=Property.new(user:current_user,property_type: type_property,property_address:address)
    @property.update(data_property)
    @property.save
    render json: property_view(@property)
  end

  def update
    @property = set_property
    if current_user.id == @property.user_id
      address = PropertyAddress.find(@property.property_address_id)
      type_property = PropertyType.find_by(name: data_property_type[:name])
      @property.update(data_property)
      @property.update(property_type:type_property)
      address.update(data_property_addres)
      @property.save
      address.save
      p "♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫"
      p type_property
      p "♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫♫"
      render json: property_view(@property)
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
    best_property = properties_sorted[0, 3].map do |property_view_id|
      property_view(property_view_id)
    end
    render json: best_property
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_view(property_found)
    {
      property: property_found,
      property_type: PropertyType.find_by(property: property_found),
      property_address: PropertyAddress.find_by(property: property_found)
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
