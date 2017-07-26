module MarketoApi
  class AbstractClient
    include MarketoApi::Concerns::Base
    include MarketoApi::Concerns::Connection
    include MarketoApi::Concerns::Authentication
    include MarketoApi::Concerns::Caching

    include MarketoApi::API::Base
    include MarketoApi::API::Leads
    include MarketoApi::API::Activities
  end
end
