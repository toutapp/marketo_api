require 'faraday'
require 'faraday_middleware'
require 'json'

require 'marketo_api/version'
require 'marketo_api/config'

module MarketoApi
  autoload :AbstractClient, 'marketo_api/abstract_client'
  autoload :Middleware,     'marketo_api/middleware'
  autoload :Client,         'marketo_api/client'

  module Concerns
    autoload :Authentication, 'marketo_api/concerns/authentication'
    autoload :Connection,     'marketo_api/concerns/connection'
    autoload :Caching,        'marketo_api/concerns/caching'
    autoload :Verbs,          'marketo_api/concerns/verbs'
    autoload :Base,           'marketo_api/concerns/base'
  end

  module API
    autoload :Base,           'marketo_api/api/base'
    autoload :Leads,          'marketo_api/api/leads'
    autoload :Sales,          'marketo_api/api/sales'
    autoload :Stats,          'marketo_api/api/stats'
    autoload :Activities,     'marketo_api/api/activities'
  end

  Error               = Class.new(StandardError)
  ServerError         = Class.new(Error)
  AuthenticationError = Class.new(Error)
  UnauthorizedError   = Class.new(Error)
  APIVersionError     = Class.new(Error)

  # Add .tap method in Ruby 1.8
  module CoreExtensions
    def tap
      yield self
      self
    end
  end

  Object.send :include, MarketoApi::CoreExtensions unless Object.respond_to? :tap
end
