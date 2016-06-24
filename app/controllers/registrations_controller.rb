class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.create(sign_up_params)

    if user.valid?
      retrun_auth_token user
    else
      return_error user
    end
  end

  def authentications
    # Use facebook grap API to get user info
    api = Koala::Facebook::API.new(params[:token], ENV['FACEBOOK_SECRET'])
    auth = api.get_object('me')
    authentication = Authentication.where(provider: params[:provider],
                                          uid: auth['id']).first
    if authentication
      retrun_auth_token authentication.user
    else
      save_user_info auth
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

  def retrun_auth_token(user)
    render json: { user: user,
                   token: AuthToken.encode(user.token_payload) },
           status: :ok
  end

  def return_error(user)
    render json: { errors: user.errors },
           status: :bad_request
  end

  def save_user_info(auth)
    user = User.new
    user.apply_auth(auth, params[:provider], params[:token])
    if user.save(validate: false)
      retrun_auth_token user
    else
      return_error user
    end
  end
end
