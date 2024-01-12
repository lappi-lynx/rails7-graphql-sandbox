namespace :graphql do
  task dump_schema: :environment do
    require 'graphql/rake_task'

    GraphQL::RakeTask.new(
      load_schema: ->(_task) {
        require File.expand_path("../../config/environment", __dir__)
        GraphqlApiSchema
      },
      directory: "./config"
    )
    Rake::Task["graphql:schema:idl"].invoke
  end
end
