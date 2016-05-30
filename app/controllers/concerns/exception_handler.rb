module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Exceptions::UnauthorizedError, with: :unauthorized
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from JWT::ExpiredSignature, with: :expired_signature
    rescue_from JWT::VerificationError, JWT::DecodeError, with: :invalid_token

    rescue_from Exceptions::InvalidTokenError, with: :invalid_token
    rescue_from Exceptions::ExpiredTokenError, with: :expired_token
    rescue_from ActionController::ParameterMissing, with: :invalid_params
    rescue_from Koala::Facebook::AuthenticationError, with: :invalid_auth_token
  end

  private

  def expired_token
    render json: { error: { message: 'Token expired' } },
           status: :bad_request
  end

  def invalid_token
    render json: { error: { message: 'Invalid Token' } },
           status: :bad_request
  end

  def unauthorized
    render json: { error: { message: 'Unauthorized' } },
           status: :unauthorized
  end

  def record_not_found
    render json: :record_not_found
  end

  def invalid_params
    render json: { error: { message: 'Invalid Parameters' } },
           status: :bad_request
  end

  def invalid_auth_token
    render json: { error: { message: 'Invalid AuthToken' } },
           status: :bad_request
  end
end
