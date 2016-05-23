class ApplicationController < ActionController::API
  protected

  def authenticate_request!
    @current_user = authenticate_user_from_jwt
  end

  private

  # This method will try to read the Authorization header (in the format
  # `Bearer <token>`) and decode it as a JWT token. Use it as a `before_action`
  # in any controller in the same way you would use `authenticate_user!`
  # The main difference is that we are writing a *stateless* so we don't store
  # sessions (cookies) and instead we authenticate _each request_ by reading
  # the Authorization http header. More on JWT here: https://jwt.io
  #
  # Brief overview:
  # We read the <token> part of the header, and attempt to decode it. If
  # there's any error while trying to read the token or decode it, we rescue
  # from the error with :status => :unauthorized
  #
  # TODO:
  # Our JSON responses in case of an error should come from an error module in
  # which we can map messages and translate them if necessary
  def authenticate_user_from_jwt
    _, token = request.headers['Authorization'].split
    decoded_token = AuthToken.decode(token)

    User.find(decoded_token[:user_id])

  # Handle expiration with 403
  rescue JWT::ExpiredSignature
    # ideally we would render the error this way:
    # render json: AuthErrors::TokenExpired.error,
    #        status: AuthErrors::TokenExpired.status
    render json: { error: { message: 'Token expired' } }, status: :bad_request

  rescue JWT::VerificationError, JWT::DecodeError
    render json: { error: { message: 'Invalid Token' } }, status: :bad_request

  rescue ActiveRecord::RecordNotFound,
         StandardError
    render json: { error: { message: 'Unauthorized' } }, status: :unauthorized
  end
end
