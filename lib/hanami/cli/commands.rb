module Hanami
  module CLI
    class Command < Dry::CLI::Command
      def application
        require "hanami/init"
        Hanami.application
      end
    end
  end
end

require_relative "application/commands/db/create"
require_relative "application/commands/db/create_migration"
require_relative "application/commands/db/drop"
require_relative "application/commands/db/migrate"
require_relative "application/commands/db/reset"
require_relative "application/commands/db/rollback"
require_relative "application/commands/db/sample_data"
require_relative "application/commands/db/seed"
require_relative "application/commands/db/structure/dump"
require_relative "application/commands/db/version"
