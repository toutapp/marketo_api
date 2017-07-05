require 'uri'
require 'Marketo/concerns/verbs'

module Marketo
  module API
    module Base
      extend Marketo::Concerns::Verbs

      # Public: Helper methods for performing arbitrary actions against the API using
      # various HTTP verbs.
      #
      # Examples
      #
      #   # Perform a get request
      #   client.get '/rest/v1/leads'
      #   client.api_get 'leads'
      #
      # Returns the Faraday::Response.
      define_verbs :get, :post, :put, :delete, :patch, :head

      # Public: Returns the daily usage of API requests
      #
      # Example
      #   client.daily_usage
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def daily_usage
        api_get('stats/usage.json')
      end

      # Public: Returns the count of each error type encountered
      # in the current day
      #
      # Example
      #   client.daily_errors
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def daily_errors
        api_get('stats/errors.json')
      end

      # Public: Returns a list of API users and the number of calls
      # they have consumed in the past 7 days.
      #
      # Example
      #   client.weekly_usage
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def weekly_usage
        api_get('stats/usage/last7days.json')
      end

      # Public: Returns a list of API users and a count of each error type
      # they have encountered in the past 7 days
      #
      # Example
      #   client.weekly_errors
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def weekly_errors
        api_get('stats/errors/last7days.json')
      end

      def format_filter_values(filter_values)
        filter_values = filter_values.join(',') if filter_values.is_a?(Array)
        filter_values
      end

      private

      # Internal: Returns a path to an api endpoint
      #
      # Examples
      #
      #   api_path('leads')
      #   # => '/rest/v1/leads'
      def api_path(path)
        "/rest/v#{options[:api_version]}/#{path}"
      end

      # Internal: Ensures that the `api_version` set for the Marketo client is at least
      # the provided version before performing a particular action
      def version_guard(version)
        if version.to_f <= options[:api_version].to_f
          yield
        else
          raise APIVersionError, "You must set an `api_version` of at least #{version} "
        end
      end

      def extract_case_insensitive_string_or_symbol_key_from_hash!(hash, key)
        value = hash.delete(key.to_sym)
        value ||= hash.delete(key.to_s)
        value ||= hash.delete(key.to_s.downcase)
        value ||= hash.delete(key.to_s.downcase.to_sym)
        value
      end

      # Internal: Errors that should be rescued from in non-bang methods
      def exceptions
        [Faraday::Error::ClientError]
      end
    end
  end
end
