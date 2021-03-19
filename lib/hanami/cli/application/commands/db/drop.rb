# frozen_string_literal: true

require "hanami/cli/command"
require "shellwords"
require_relative "utils/database_config"

module Hanami
  module CLI
    module Application
      module Commands
        module DB
          class Drop < Command
            desc "Delete database"

            def call(**)
              db_name = database_config.db_name

              system(database_config.cli_env_vars, "dropdb #{Shellwords.escape(db_name)}")
              out.puts "=> database #{db_name} dropped" if $?.success?
            end

            private

            def database_config
              @database_config ||= Utils::DatabaseConfig.for_application(application)
            end
          end
        end
      end
    end

    register "db drop", Application::Commands::DB::Drop
  end
end
