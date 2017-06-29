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
      #   client.get '/rest/v24.0/leads'
      #   client.api_get 'leads'
      #
      # Returns the Faraday::Response.
      define_verbs :get, :post, :put, :delete, :patch, :head

      # Public: Returns a detailed describe result for the specified sobject
      #
      # Example
      #   # get the describe for the Leads object
      #   client.describe('leads')
      #   # => { ... }
      #
      # Returns the Hash representation of the describe call.
      def describe(object)
        api_get("#{object.downcase}/describe.json")
      end

      # Public: Executes specific entity request and returns the result.
      #
      # Example
      #   # Find the specific lead
      #   client.query('leads', '318581')
      #   # => {
      #         "requestId": "10226#14d3049e51b",
      #         "success": true,
      #         "result": [
      #            {
      #               "id": 318581,
      #               "updatedAt":"2015-05-07T11:47:30-08:00"
      #               "lastName": "Doe",
      #               "email": "jdoe@marketo.com",
      #               "createdAt": "2015-05-01T16:47:30-08:00",
      #               "firstName": "John"
      #            }
      #         ]
      #      }
      #
      def query(object, id)
        api_get("#{object}/#{id}.json")
      end

      private

      # Internal: Returns a path to an api endpoint
      #
      # Examples
      #
      #   api_path('leads')
      #   # => '/rest/v24.0/leads'
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
