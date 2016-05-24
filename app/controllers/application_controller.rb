class ApplicationController < ActionController::API
  include ExceptionHandler

  protected

  def authenticate_request!
    @current_user = authenticate_user_from_jwt
    raise Exceptions::UnauthorizedError unless @current_user
  end

  def authenticate_admin_request!
    authenticate_request!
    raise Exceptions::UnauthorizedError unless @current_user.is_admin?
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
  def authenticate_user_from_jwt
    _, token = request.headers['Authorization'].split
    decoded_token = AuthToken.decode(token)
    User.find(decoded_token[:user_id])
  rescue NoMethodError
    raise Exceptions::UnauthorizedError
  end
end
