# frozen_string_literal: true

require 'rails_helper'
require 'json_web_token'

RSpec.describe 'Authentication' do
  context 'when the request does not includes an Authorization header' do
    it 'returns 401 :unauthorized' do
      get root_path

      expect(response).to have_http_status(401)
    end
  end

  context 'when the request includes an Authorization header' do
    before do
      allow(JsonWebToken).to receive(:key).and_return(rsa_private.public_key)
    end

    context 'and the JWT has invalid issuer' do
      let(:jwt) { JWT.encode(invalid_issuer_payload, rsa_private, 'RS256') }

      it 'returns 401 :unauthorized and JWT error' do
        get root_path, headers: { 'Authorization' => "bearer #{jwt}" }

        expect{ JsonWebToken.verify(jwt) }.to raise_error(JWT::InvalidIssuerError)

        expect(response).to have_http_status(401)
      end
    end

    context 'and the JWT has invalid audience' do
      let(:jwt) { JWT.encode(invalid_audience_payload, rsa_private, 'RS256') }

      it 'returns 401 :unauthorized and JWT error' do
        get root_path, headers: { 'Authorization' => "bearer #{jwt}" }

        expect{ JsonWebToken.verify(jwt) }.to raise_error(JWT::InvalidAudError)

        expect(response).to have_http_status(401)
      end
    end

    context 'and the JWT has expired signature' do
      let(:jwt) { JWT.encode(expired_signature_payload, rsa_private, 'RS256') }

      it 'returns 401 :unauthorized and JWT error' do
        get root_path, headers: { 'Authorization' => "bearer #{jwt}" }

        expect{ JsonWebToken.verify(jwt) }.to raise_error(JWT::ExpiredSignature)

        expect(response).to have_http_status(401)
      end
    end

    context 'and the JWT has immature signature' do
      let(:jwt) { JWT.encode(immature_signature_payload, rsa_private, 'RS256') }

      it 'returns 401 :unauthorized and JWT error' do
        get root_path, headers: { 'Authorization' => "bearer #{jwt}" }

        expect{ JsonWebToken.verify(jwt) }.to raise_error(JWT::ImmatureSignature)

        expect(response).to have_http_status(401)
      end
    end

    context 'and the JWT is valid' do
      let(:jwt) { JWT.encode(valid_jwt_payload, rsa_private, 'RS256') }

      it 'returns 200' do
        get root_path, headers: { 'Authorization' => "bearer #{jwt}" }


        expect(response).to have_http_status(200)
      end
    end
  end

  def rsa_private
    @rsa_private ||= OpenSSL::PKey::RSA.generate 2048
  end

  def invalid_issuer_payload
    { data: 'data',
      exp: Time.now.to_i + 4 * 3600,
      nbf: Time.now.to_i - 10000,
      aud: Rails.application.credentials[Rails.env.to_sym][:audience],
      iss: 'WRONG' }
  end

  def invalid_audience_payload
    { data: 'data',
      exp: Time.now.to_i + 4 * 3600,
      nbf: Time.now.to_i - 10000,
      aud: 'WRONG',
      iss: Rails.application.credentials[Rails.env.to_sym][:issuerUri] }
  end

  def expired_signature_payload
    { data: 'data',
      exp: Time.now.to_i - 10000,
      nbf: Time.now.to_i - 10000,
      aud: Rails.application.credentials[Rails.env.to_sym][:audience],
      iss: Rails.application.credentials[Rails.env.to_sym][:issuerUri] }
  end

  def valid_jwt_payload
    { data: 'data',
      exp: Time.now.to_i + 4 * 3600,
      nbf: Time.now.to_i - 10000,
      aud: Rails.application.credentials[Rails.env.to_sym][:audience],
      iss: Rails.application.credentials[Rails.env.to_sym][:issuerUri] }
  end

  def immature_signature_payload
    { data: 'data',
      exp: Time.now.to_i + 4 * 3600,
      nbf: Time.now.to_i + 10000,
      aud: Rails.application.credentials[Rails.env.to_sym][:audience],
      iss: Rails.application.credentials[Rails.env.to_sym][:issuerUri] }
  end

end
