module Marketo
  # Faraday middleware that allows for on the fly authentication of requests.
  # When a request fails (a status of 401 is returned), the middleware
  # will attempt to either reauthenticate (request new access_token).
  class Middleware::Authentication < Marketo::Middleware
    autoload :Token,    'marketo/middleware/authentication/token'

    # Rescue from 401's, authenticate then raise the error again so the client
    # can reissue the request.
    def call(env)
      @app.call(env)
    rescue Marketo::UnauthorizedError
      authenticate!
      raise
    end

    # Internal: Performs the authentication and returns the response body.
    def authenticate!
      url = @options[:instance_url] + '/identity/oauth/token?' + URI.encode_www_form(params)
      response = connection.get(url)

      if response.status >= 500
        raise Marketo::ServerError, error_message(response)
      elsif response.status != 200
        raise Marketo::AuthenticationError, error_message(response)
      end

      @options[:oauth_token]  = response.body['access_token']
      @options[:expires_in]  = response.body['expires_in']

      response.body
    end

    # Internal: The params to post to the OAuth service.
    def params
      raise NotImplementedError
    end

    # Internal: Faraday connection to use when sending an authentication request.
    def connection
      @connection ||= Faraday.new(faraday_options) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.response :json

        builder.use Marketo::Middleware::Logger,
                    Marketo.configuration.logger,
                    @options if Marketo.log?

        builder.adapter @options[:adapter]
      end
    end

    # Internal: The parsed error response.
    def error_message(response)
      "#{response.body['error']}: #{response.body['error_description']}"
    end

    private

    def faraday_options
      { url: @options[:instance_url], ssl: @options[:ssl] }
    end
  end
end
