module Marketo
  class AbstractClient
    include Marketo::Concerns::Base
    include Marketo::Concerns::Connection
    include Marketo::Concerns::Authentication
    include Marketo::Concerns::Caching

    include Marketo::API::Base
    include Marketo::API::Leads
  end
end
