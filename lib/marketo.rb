require 'faraday'
require 'faraday_middleware'
require 'json'

require 'marketo/version'
require 'marketo/config'

module Marketo
  autoload :AbstractClient, 'marketo/abstract_client'
  autoload :Middleware,     'marketo/middleware'
  autoload :Client,         'marketo/client'

  module Concerns
    autoload :Authentication, 'marketo/concerns/authentication'
    autoload :Connection,     'marketo/concerns/connection'
    autoload :Caching,        'marketo/concerns/caching'
    autoload :Verbs,          'marketo/concerns/verbs'
    autoload :Leads,          'marketo/concerns/leads'
    autoload :Base,           'marketo/concerns/base'
    autoload :API,            'marketo/concerns/api'
  end

  module Data
    autoload :Client, 'marketo/data/client'
  end

  Error               = Class.new(StandardError)
  ServerError         = Class.new(Error)
  AuthenticationError = Class.new(Error)
  UnauthorizedError   = Class.new(Error)
  APIVersionError     = Class.new(Error)

  class << self
    # Alias for Marketo::Data::Client.new
    #
    # Shamelessly pulled from https://github.com/pengwynn/octokit/blob/master/lib/octokit.rb
    def new(*args, &block)
      data(*args, &block)
    end

    def data(*args, &block)
      Marketo::Data::Client.new(*args, &block)
    end
  end

  # Add .tap method in Ruby 1.8
  module CoreExtensions
    def tap
      yield self
      self
    end
  end
  Object.send :include, Marketo::CoreExtensions unless Object.respond_to? :tap
end
