class SpaceTypesController < ApplicationController
  before_action :authenticate_admin_request!, except: [:index, :show]
  before_action :set_space_type, only: [:show, :update, :destroy]

  # GET /space_types
  def index
    @space_types = SpaceType.all
    render json: @space_types
  end

  # GET /space_types/:id
  def show
    render json: @space_type
  end

  # POST /space_types
  def create
    @space_type = SpaceType.new(create_space_type_params)
    if @space_type.save
      render json: @space_type, status: :created, location: @space_type
    else
      render json: @space_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /space_types/:id
  def update
    if @space_type.update(update_space_type_params)
      render json: @space_type
    else
      render json: @space_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /space_types/:id
  def destroy
    if @space_type.destroy
      render json: :ok
    else
      render json: :bad_request
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_space_type
    @space_type = SpaceType.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def update_space_type_params
    params.require(:space_type).permit(:id, :name)
  end

  def create_space_type_params
    params.require(:space_type).permit(:name)
  end
end
