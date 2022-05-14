# frozen_string_literal: true

require 'json_web_token'

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authorize!
  end

  def authorize!
    valid, result = verify(raw_token(request.headers))

    head :unauthorized unless valid

    @token ||= result
  end

  private

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
end
