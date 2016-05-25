class SessionsController < Devise::SessionsController
  def create
    credentials = params[:credentials]
    user = User.find_by_email(credentials[:email])

    if user && user.valid_password?(credentials[:password])
      render json: { user: user,
                     token: AuthToken.encode(user.token_payload) },
             status: :ok
    else
      return head(:unauthorized)
    end
  end
end
