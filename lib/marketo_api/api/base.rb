require 'uri'
require 'marketo_api/concerns/verbs'

module MarketoApi
  module API
    module Base
      extend MarketoApi::Concerns::Verbs

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

      # TODO: (MT) Move this to a helper
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

      # Internal: Converts a hash into a string that can be consumed by
      # the Marketo API as a query string
      #
      # Examples
      #
      #   to_query({ source: 'Sales Engage', workspaceName: 'Global' })
      #   # => 'source=Sales%20Engage&workspaceName=Global'
      def to_query(options = {})
        options.to_query.gsub('+', '%20')
      end

      # Internal: Append a nextPageToken to a url if token is present
      #
      # Examples
      #
      #   add_next_page_token('activities.json?')
      #   # => '/rest/v1/leads'
      def add_next_page_token(path, token)
        path += "&nextPageToken=#{token}" if token
        path
      end

      # Internal: Returns hash for next page token param
      #
      # Examples
      #
      #   add_next_page_token('123')
      #   # => { nextPageToken: '123' }
      def paging_token_param(token)
        token.present? ? { nextPageToken: token } : {}
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
