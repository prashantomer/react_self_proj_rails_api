class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)
    if user.save
      render json: { token: AuthToken.encode(user.token_payload) }
    else
      # super
      render json: user.errors.messages
    end
  end

  private

  def sign_up_params
    params
      .require(:user)
      .permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
  end
end
