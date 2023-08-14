# frozen_string_literal: true

require 'forwardable'

module MarketoApi
  class Middleware::Logger < Faraday::Middleware
    extend Forwardable

    def initialize(app, logger, options)
      super(app)
      @options = options
      @logger = logger || begin
        require 'logger'
        ::Logger.new($stdout)
      end
    end

    def_delegators :@logger, :debug, :info, :warn, :error, :fatal

    def call(env)
      debug('request') do
        dump :url => env[:url].to_s,
             :method => env[:method],
             :headers => env[:request_headers],
             :body => env[:body]
      end
      super
    end

    def on_complete(env)
      debug('response') do
        dump :status => env[:status].to_s,
             :headers => env[:response_headers],
             :body => env[:body]
      end
    end

    def on_error(exc)
      debug('response') do
        dump :details => "#{self.class.name}::#{__method__} - Exception: #{exc.message}",
             :backtrace => exc.backtrace.join("\n")
      end
    end

    def dump(hash)
      "\n" + hash.map { |k, v| "  #{k}: #{v.inspect}" }.join("\n")
    end
  end
end
