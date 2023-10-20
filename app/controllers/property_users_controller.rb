class PropertyUsersController < ApplicationController
  before_action :set_property_user, only: %i[show update destroy]
  before_action :authorize

  # GET /property_users
  def index
    @property_users = PropertyUser.where(user:current_user.id)
    result = @property_users.map do |property_view_id|
      property_view(Property.find(property_view_id.user_id))
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
    if @property_user.save
      render json: @property_user, status: :created
    else
      render json: @property_user.errors, status: :unprocessable_entity
    end
  end

  def listfavorites
    @favorite = PropertyUser.where(user: current_user, favorite: true)
    p @favorite
    @nuevo_arreglo = @favorite.map do |fav|
      showProperty = Property.find(fav.property_id)
      { property: showProperty, address: PropertyAddress.find(showProperty.property_address_id) }
    end
    p @nuevo_arreglo

    Rails.logger.debug @favorite
    render json: @nuevo_arreglo
  end

  def listcontacts
    @contact = PropertyUser.where(user: current_user, contacted: true)
    @nuevo_arreglo = @contact.map do |cont|
      Property.find(cont.property_id)
    end
    Rails.logger.debug @contact
    render json: @nuevo_arreglo
  end

  def listland
    User.where(role_id: 1)
    @property_sale = PropertyForSale.all
    render json: @property_sale
  end

  # GET /listhome
  def listhome
    User.where(role_id: 2)
    @property_rent = PropertyForRent.all
    render json: @property_rent
  end

  # PATCH/PUT /property_users/1
  def update
    if @property_user.update(property_user_params)
      render json: @property_user
    else
      render json: @property_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /property_users/1
  def destroy
    @property_user.destroy
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
    params.require(:property_user).permit(:user_id, :property_id, :favorite, :contacted)
  end
end
