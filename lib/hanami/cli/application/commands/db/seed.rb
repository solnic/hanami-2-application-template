# frozen_string_literal: true

require "hanami/cli/command"

module Hanami
  module CLI
    module Application
      module Commands
        module DB
          class Seed < Command
            desc "Load database seeds"

            def call(**)
              if has_file?
                measure "Database seeds loaded" do
                  load file_path
                end
              else
                out.puts "=> no database seeds available"
              end
            end

            private

            def file_path
              File.join(application.root, "db/seed.rb")
            end

            def has_file?
              File.exist?(file_path)
            end
          end
        end
      end
    end

    register "db seed", Application::Commands::DB::Seed
  end
end
