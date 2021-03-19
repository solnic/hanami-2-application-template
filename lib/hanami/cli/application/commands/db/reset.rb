# frozen_string_literal: true

require "hanami/cli/command"
require_relative "create"
require_relative "drop"
require_relative "migrate"

module Hanami
  module CLI
    module Application
      module Commands
        module DB
          class Reset < Command
            desc "Drop, create, and migrate database"

            def call(**)
              run_command Drop
              run_command Create
              run_command Migrate
            end
          end
        end
      end
    end

    register "db reset", Application::Commands::DB::Reset
  end
end
