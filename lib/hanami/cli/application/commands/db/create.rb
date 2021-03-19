require "hanami/cli/command"
require "shellwords"
require_relative "utils/database_config"

module Hanami
  module CLI
    module Application
      module Commands
        module DB
          class Create < Command
            desc "Create database"

            def call(**)
              db_name = database_config.db_name

              system(database_config.cli_env_vars, "createdb #{Shellwords.escape(db_name)}")
              out.puts "=> database #{db_name} created" if $?.success?
            end

            private

            def database_config
              @database_config ||= Utils::DatabaseConfig.for_application(application)
            end
          end
        end
      end
    end

    register "db create", Application::Commands::DB::Create
  end
end
