# Totally took this from Restforce.
require 'logger'

module Marketo
  class << self
    attr_writer :log

    # Returns the current Configuration
    #
    # Example
    #
    #    Marketo.configuration.api_version = "1.0"
    #    Marketo.configuration.cache = "ActiveSupport::Cache.lookup_store :redis_store"
    def configuration
      @configuration ||= Configuration.new
    end

    # Yields the Configuration
    #
    # Example
    #
    #    Marketo.configure do |config|
    #      config.api_version = "1.0"
    #      config.cache = "ActiveSupport::Cache.lookup_store :redis_store"
    #    end
    def configure
      yield configuration
    end

    def log?
      @log ||= false
    end

    def log(message)
      return unless Marketo.log?
      configuration.logger.send(configuration.log_level, message)
    end
  end

  class Configuration
    class Option
      attr_reader :configuration, :name, :options

      def self.define(*args)
        new(*args).define
      end

      def initialize(configuration, name, options = {})
        @configuration = configuration
        @name = name
        @options = options
        @default = options.fetch(:default, nil)
      end

      def define
        write_attribute
        define_method if default_provided?
        self
      end

      private

      attr_reader :default
      alias_method :default_provided?, :default

      def write_attribute
        configuration.send :attr_accessor, name
      end

      def define_method
        our_default = default
        our_name    = name
        configuration.send :define_method, our_name do
          instance_variable_get(:"@#{our_name}") ||
            instance_variable_set(
              :"@#{our_name}",
              our_default.respond_to?(:call) ? our_default.call : our_default
            )
        end
      end
    end

    class << self
      attr_accessor :options

      def option(*args)
        option = Option.define(self, *args)
        (self.options ||= []) << option.name
      end
    end

    option :api_version, default: lambda { ENV['MARKETO_API_VERSION'] || '1.0' }

    # The OAuth client id
    option :client_id, default: lambda { ENV['MARKETO_CLIENT_ID'] }

    # The OAuth client secret
    option :client_secret, default: lambda { ENV['MARKETO_CLIENT_SECRET'] }

    # Set this to true if you're authenticating with a Sandbox instance.
    # Defaults to false.
    option :host, default: lambda { ENV['MARKETO_HOST'] || 'login.marketo.com' }

    option :oauth_token
    # option :refresh_token
    option :instance_url

    # Set this to an object that responds to read, write and fetch and all GET
    # requests will be cached.
    option :cache

    # The number of times reauthentication should be tried before failing.
    option :authentication_retries, default: 3

    # Faraday request read/open timeout.
    option :timeout

    # Faraday adapter to use. Defaults to Faraday.default_adapter.
    option :adapter, default: lambda { Faraday.default_adapter }

    # Set SSL options
    option :ssl, default: {}

    # A Hash that is converted to HTTP headers
    option :request_headers

    # Set a logger for when Marketo.log is set to true, defaulting to STDOUT
    option :logger, default: ::Logger.new(STDOUT)

    # Set a log level for logging when Marketo.log is set to true, defaulting to :debug
    option :log_level, default: :debug

    def options
      self.class.options
    end
  end
end
