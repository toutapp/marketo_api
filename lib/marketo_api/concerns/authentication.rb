module MarketoApi
  module Concerns
    module Authentication
      # Public: Force an authentication
      def authenticate!
        unless authentication_middleware
          raise AuthenticationError, 'No authentication middleware present'
        end

        middleware = authentication_middleware.new nil, self, options
        middleware.authenticate!
      end

      # Internal: Determines what middleware will be used based on the options provided
      def authentication_middleware
        MarketoApi::Middleware::Authentication::Token
      end
    end
  end
end
