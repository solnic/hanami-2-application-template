# frozen_string_literal: true

require "hanami/cli/command"
require_relative "structure/dump"
require_relative "utils/database"

module Hanami
  module CLI
    module Application
      module Commands
        module DB
          class Migrate < Command
            desc "Migrates database"

            option :target, desc: "Target migration number", aliases: ["-t"]

            def call(target: nil, **)
              return if Dir[File.join(application.root, "db/migrate/*.rb")].empty?

              measure "database #{database.name} migrated" do
                if target
                  run_migrations(target: Integer(target))
                else
                  run_migrations
                end
              end

              run_command Structure::Dump
            end

            private

            def run_migrations(**options)
              ROM::SQL.with_gateway(database.gateway) do
                database.migrator.run(options)
              end
            end

            def database
              @database ||= Utils::Database.for_application(application)
            end
          end
        end
      end
    end

    register "db migrate", Application::Commands::DB::Migrate
  end
end

