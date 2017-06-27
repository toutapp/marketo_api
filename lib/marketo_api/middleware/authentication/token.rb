module MarketoApi
  # Authentication middleware used to fetch the access_token
  class Middleware::Authentication::Token < MarketoApi::Middleware::Authentication
    def params
      {
        grant_type: 'client_credentials',
        client_id: @options[:client_id],
        client_secret: @options[:client_secret]
      }
    end
  end
end
