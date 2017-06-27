module Marketo
  # Middleware the converts records from JSON into Marketo::SObject objects
  # and collections of records into Marketo::Collection objects.
  class Middleware::Mashify < Marketo::Middleware
    def call(env)
      @app.call(env).on_complete do |completed_env|
        completed_env[:body] = Marketo::Mash.build(completed_env[:body], client)
      end
    end
  end
end
