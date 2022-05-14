require 'rails_helper'

RSpec.describe Expression, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:definition) }
    it { should validate_presence_of(:context) }
    it { should validate_presence_of(:context_source) }
  end
end
