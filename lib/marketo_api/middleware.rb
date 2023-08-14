module MarketoApi
  # Base class that all middleware can extend. Provides some convenient helper
  # functions.
  class Middleware < Faraday::Middleware
    autoload :RaiseError,     'marketo_api/middleware/raise_error'
    autoload :Authentication, 'marketo_api/middleware/authentication'
    autoload :Authorization,  'marketo_api/middleware/authorization'
    autoload :Caching,        'marketo_api/middleware/caching'
    autoload :CachingStrategy,'marketo_api/middleware/caching_strategy'
    autoload :Logger,         'marketo_api/middleware/logger'

    def initialize(app, client, options)
      @app = app
      @client = client
      @options = options
    end

    # Internal: Proxy to the client.
    def client
      @client
    end

    # Internal: Proxy to the client's faraday connection.
    def connection
      client.send(:connection)
    end
  end
end
