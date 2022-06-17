# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expressions::SyncService, type: :service do
  let(:service_call) { described_class.call(expressions: yml_expressions, dry_run: false) }

  context 'when yml_expressions == db_expressions' do
    let(:yml_expressions) { Array.wrap(attributes_for(:expression)) }

    before do
      create_expression
    end

    it 'does not sync new expressions' do
      expect(Expression.count).to be 1

      service_call

      expect(Expression.count).to be 1
    end
  end

  context 'yml_expressions > db_expressions' do
    let(:yml_expressions) { [attributes_for(:expression), attributes_for(:expression, :two)] }

    before do
      create_expression
    end

    it 'create new expression' do
      expect(Expression.count).to be 1

      service_call

      expect(Expression.count).to be 2
    end
  end

  context 'when they have different attributes' do
  end

  it 'test' do
  end

  def create_expression
    @expression = create(:expression)
  end
end
