# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { build(:user) }

  before do
    allow(Current).to receive(:user).and_return(user)
    allow(user).to receive(:email).and_return(user.email)
  end

  describe "GET /show" do
    it 'returns user data' do
      get '/user', headers: authorization_header

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.body).to include(user.name, user.email)
    end
  end
end
