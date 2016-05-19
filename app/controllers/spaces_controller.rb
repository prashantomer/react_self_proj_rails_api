class SpacesController < ApplicationController

  def index
    if params[:user_id]
      list_user_spaces(params[:user_id])
    else
      @spaces = Space.all
      render json: @spaces
    end
  end

  def show
    @space = Space.find(params[:id])

    render :json => @space
  end

  private

  def list_user_spaces(user_id)
    @spaces = Space.where(user_id: user_id)
    render json: @spaces
  end
end
