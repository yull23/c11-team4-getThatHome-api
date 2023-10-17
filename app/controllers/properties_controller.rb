class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show update destroy]
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
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def create
    address = PropertyAddress.new(modify_params(params[:address], ["name"]))
    unless address.save
      return render json: { address: ["Incorrect data"] },
                    status: :unprocessable_entity
    end

    photos = params[:photo_url]
    # op_type = params[:operation_type]
    other_data_keys = ["bedrooms", "bathrooms", "area", "description", "active",
                       "property_type_id"]
    other_data = property_params.select { |k, _v| other_data_keys.include?(k) }
    # "merge!" modifica el hash original directamente
    body = other_data.merge!({ photo_url: photos, property_address: address })

    @property = Property.new(body)
    if @property.save
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update
    # return render status: :unauthorized #unless current_user.role_name == "Landlord"
    address = PropertyAddress.find_by(id: @property.property_address_id)
    address.update(modify_params(params[:address], ["name"])) if params[:address].present?
    photos = params[:photo_url]
    data_keys = ["bedrooms", "bathrooms", "area", "description", "active", "property_type_id"]
    other_data = property_params.select { |k, _v| data_keys.include?(k) }

    body = photos.present? ? other_data.merge!({ photo_url: photos }) : other_data
    if @property.update(body)
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.permit(:bedrooms, :bathrooms, :area, :description, :active, :property_type_id, :property_address_id,
                  :photo_url)
  end

  # guarda data a una tabla hash
  def modify_params(hash, exceptions)
    keys = hash.keys
    new_hash = {}
    keys.each { |k| new_hash[k] = hash[k] }
    new_hash.map { |k, v| { k => exceptions.include?(k) ? v : v.to_f } }.reduce(:merge)
  end
end
