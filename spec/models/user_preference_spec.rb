# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPreference, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:periodicity) }
    it { should belong_to(:user) }
  end
end
