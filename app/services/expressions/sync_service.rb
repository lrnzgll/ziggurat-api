# frozen_string_literal: true

module Expressions
  # Loads expressions from the 'Ziggurat' gem. Compare expressions in the gem with expressions in the DB and create new expressions if they are not already in the DB
  class SyncService
    def self.call(expressions:, dry_run: true)
      new(expressions: expressions, dry_run: dry_run).call
    end

    def initialize(expressions:, dry_run: true)
      @expressions = expressions
      @dry_run = dry_run
    end

    def call; end

    private

    def yml_expressions
      @yml_expressions ||= @expressions.dig('data', 'expressions').map do |expression|
        expression
      end
    end

    def db_expressions
      @db_expressions ||= Expression.all.map(&:attributes)
    end
  end
end
