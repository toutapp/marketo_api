module Marketo
  module Concerns
    module Base
      attr_reader :options

      # Public: Creates a new client instance
      #
      # opts - A hash of options to be passed in (default: {}).
      #        :oauth_token             - The String oauth access token to authenticate
      #                                   API calls (required unless password
      #                                   authentication is used).
      #        :instance_url            - The String base url for all api requests
      #                                   (required if oauth authentication is used).
      #
      #        :client_id               - The oauth client id to use. Needed for both
      #                                   password and oauth authentication
      #        :client_secret           - The oauth client secret to use.
      #
      #        :api_version             - The String REST api version to use
      #                                   (default: '24.0')
      #
      #        :timeout                 - Faraday connection request read/open timeout.
      #                                   (default: nil).
      #
      #        :request_headers         - A hash containing custom headers that will be
      #                                   appended to each request

      def initialize(opts = {})
        raise ArgumentError, 'Please specify a hash of options' unless opts.is_a?(Hash)

        @options = Hash[Marketo.configuration.options.map do |option|
          [option, Marketo.configuration.send(option)]
        end]

        @options.merge! opts
        yield builder if block_given?
      end

      def instance_url
        authenticate! unless options[:instance_url]
        options[:instance_url]
      end

      def inspect
        "#<#{self.class} @options=#{@options.inspect}>"
      end
    end
  end
end
