# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:auth_id) }
    it { should validate_presence_of(:name) }
    it { should have_many(:user_preferences).dependent(:destroy) }
  end
end
