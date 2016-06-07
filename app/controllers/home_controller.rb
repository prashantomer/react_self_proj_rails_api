class HomeController < ApplicationController
  def index
    render json: "Welcome to Compartir Espacios API"
  end
end
