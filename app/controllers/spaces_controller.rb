class SpacesController < ApplicationController
  before_action :authenticate_request!, except: [:index]
  before_action :set_space, only: [:images, :update, :destroy]

  def index
    if params[:user_id]
      list_user_spaces(params[:user_id])
    else
      @spaces = Space.all
      render json: @spaces
    end
  end

  def show
    space = Space.find(params[:id])
    render json: space
  end

  def create
    @space = @current_user.spaces.new(space_params)
    set_amenities
    if @space.save
      render json: @space, status: :created, location: @space
    else
      render json: @space.errors, status: :unprocessable_entity
    end
  end

  def update
    set_amenities
    if @space.update(space_params)
      render json: @space
    else
      render json: @space.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @space.destroy
      render json: :ok
    else
      render json: :bad_request
    end
  end

  def images
    if params[:images].present?
      params[:images].each do |image|
        space_image = @space.space_images.new
        space_image.update_attribute(:image, image)
      end
    end
    render json: @space
  end

  private

  def list_user_spaces(user_id)
    @spaces = Space.where(user_id: user_id)
    render json: @spaces
  end

  def set_space
    @space = if @current_user.is_admin?
               Space.find(params[:id])
             else
               @current_user.spaces.find(params[:id])
             end
  end

  def space_params
    params.require(:space).permit(:user_id, :space_type_id,
                                  :title, :slug,
                                  :description, :address_line_1,
                                  :address_line_2, :city,
                                  :state, :country,
                                  :latitude, :longitude, :capacity)
  end

  def set_amenities
    if params[:space][:amenities].present?
      @space.amenities = Amenity.where(id: params[:space][:amenities])
    end
  end
end
