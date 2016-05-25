class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.create(sign_up_params)

    if user.valid?
      render json: { token: AuthToken.encode(user.token_payload) },
             status: :ok
    else
      render json: { errors: user.errors },
             status: :bad_request
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
