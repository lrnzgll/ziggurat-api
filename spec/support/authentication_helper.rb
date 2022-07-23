# frozen_string_literal: true

module AuthenticationHelper
  def authorization_header
    { 'Authorization' => "bearer #{jwt}" }
  end

  def rsa_public
    rsa_private.public_key
  end

  private

  def jwt
    JWT.encode(jwt_payload, rsa_private, 'RS256')
  end

  def jwt_payload
    { data: 'data',
      exp: Time.now.to_i + 4 * 3600,
      nbf: Time.now.to_i - 10_000,
      aud: Rails.application.credentials[Rails.env.to_sym][:audience],
      iss: Rails.application.credentials[Rails.env.to_sym][:issuerUri] }
  end

  def rsa_private
    @rsa_private ||= OpenSSL::PKey::RSA.generate 2048
  end
end
