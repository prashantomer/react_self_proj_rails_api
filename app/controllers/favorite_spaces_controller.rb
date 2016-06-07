class FavoriteSpacesController < ApplicationController
  before_action :authenticate_request!, except: [:index]

  # GET /favorite_spaces
  def index
    user = User.find(params[:user_id])
    render json: user.favorite_spaces
  end

  # POST /favorite_spaces
  def create
    favorite_space = @current_user.favorite_spaces.new(favorite_space_params)
    if favorite_space.save
      render json: favorite_space, status: :created, location: favorite_space
    else
      render json: favorite_space.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorite_spaces/:id
  def destroy
    favorite_space = @current_user.favorite_spaces.find(params[:id])

    if favorite_space.destroy
      render json: :ok
    else
      render json: :bad_request
    end
  end

  private

  def favorite_space_params
    params.require(:favorite_spaces).permit(:space_id)
  end
end
