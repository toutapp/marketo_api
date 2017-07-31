module MarketoApi
  # Faraday middleware that allows for on the fly authentication of requests.
  # When a request fails (a status of 401 is returned), the middleware
  # will attempt to either reauthenticate (request new access_token).
  class Middleware::Authentication < MarketoApi::Middleware
    autoload :Token, 'marketo_api/middleware/authentication/token'

    # Rescue from 401's, authenticate then raise the error again so the client
    # can reissue the request.
    def call(env)
      @app.call(env)
    rescue MarketoApi::UnauthorizedError
      authenticate!
      raise
    end

    # Internal: Performs the authentication and returns the response body.
    def authenticate!
      encoded_params = URI.encode_www_form(params)
      token_url = @options[:instance_url] + '/identity/oauth/token'
      url = "#{token_url}?#{encoded_params}"
      response = connection.get(url)

      if response.status >= 500
        raise MarketoApi::ServerError, error_message(response)
      elsif response.status != 200
        raise MarketoApi::AuthenticationError, error_message(response)
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
        builder.use(Faraday::Request::UrlEncoded)
        builder.response(:json)

        builder.use(MarketoApi::Middleware::Logger, MarketoApi.configuration.logger, @options) if MarketoApi.log?

        builder.adapter(@options[:adapter])
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
