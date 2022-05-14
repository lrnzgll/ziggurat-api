# frozen_string_literal: true

require 'jwt'
require 'net/http'

class JsonWebToken
  class << self
    def verify(token)
      JWT.decode(token, nil,
                 true, # Verify the signature of this token
                 algorithm: algorithm,
                 iss: Rails.application.credentials[Rails.env.to_sym][:issuerUri],
                 verify_iss: true,
                 aud: Rails.application.credentials[Rails.env.to_sym][:audience],
                 verify_aud: true) do |header|
                  key(header)
      end
    end

    def algorithm
      'RS256'
    end

    def key(header)
      jwks_hash[header['kid']]
    end

    def jwks_hash
      Rails.cache.fetch("#{issuer}-jwks_hash", expires_in: 1.hour) do
        jwks_keys = Array(JSON.parse(Net::HTTP.get URI("#{issuer}.well-known/jwks.json"))['keys'])
        jwks_keys.map do |k|
          [
            k['kid'],
            OpenSSL::X509::Certificate.new(Base64.decode64(k['x5c'].first)).public_key
          ]
        end.to_h
      end
    end

    def issuer
      "#{Rails.application.credentials[Rails.env.to_sym][:issuerUri]}"
    end
  end
end
