class PropertyUsersController < ApplicationController
  before_action :set_property_user, only: %i[show update destroy]
  before_action :authorize

  # GET /property_users
  def index
    @property_users = PropertyUser.all
    render json: @property_users
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
    @nuevo_arreglo = @favorite.map do |fav|
      Property.find(fav.property_id)
    end
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

  def set_property_user
    @property_user = PropertyUser.find(params[:id])
  end

  def property_user_params
    params.require(:property_user).permit(:user_id, :property_id, :favorite, :contacted)
  end
end
