# frozen_string_literal: true

module ZigguratApi
  # Loads the expressions.yml file and compare expressions in the database with expressions in the file.
  # If there are new expressions in the yml file, they are added to the database.
  class Application < Rails::Application
    config.after_initialize do
      #      Expressions::SyncService.call(
      #        expressions: YAML.safe_load(Ziggurat::Expressions::List.yml),
      #        dry_run: false)
    end
  end
end
