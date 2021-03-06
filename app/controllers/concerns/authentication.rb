# frozen_string_literal: true

require 'json_web_token'

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authorize!
  end

  def authorize!
    valid, result = verify(raw_token(request.headers))

    return head :unauthorized unless valid

    authenticate(result)
  end

  private

  def authenticate(result)
    authenticated_user =
      User.find_by(auth_id: result['sub']) ||
      User.create(auth_id: result['sub'], name: result["#{claims}/username"])

    Current.user = authenticated_user
    Current.user.email = result["#{claims}/email"]
  end

  def verify(token)
    payload, = JsonWebToken.verify(token)
    [true, payload]
  rescue JWT::DecodeError => e
    [false, e]
  end

  def raw_token(headers)
    return headers['Authorization'].split.last if headers['Authorization'].present?

    nil
  end

  def claims
    "#{request.base_url}/claims"
  end
end
