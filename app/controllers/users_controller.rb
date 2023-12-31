class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  skip_before_action :authorize, only: :create

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    unless current_user.role_id == 1
      return render json: { error: "Usuario no autorizado" },
                    status: :unauthorized
    end

    render json: User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  def create
    @user = User.new(user_params)
    Rails.logger.debug @user.name
    Rails.logger.debug @user.role
    if @user.save
      render json: @user, status: :created # 201
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed.", status: :see_other
  end

  def profile
    render json: current_user
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :phone, :password_digest, :role_id)
  end
end
