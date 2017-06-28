module Marketo
  # Base class that all middleware can extend. Provides some convenient helper
  # functions.
  class Middleware < Faraday::Middleware
    autoload :RaiseError,     'marketo/middleware/raise_error'
    autoload :Authentication, 'marketo/middleware/authentication'
    autoload :Authorization,  'marketo/middleware/authorization'
    autoload :Caching,        'marketo/middleware/caching'
    autoload :Logger,         'marketo/middleware/logger'

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
