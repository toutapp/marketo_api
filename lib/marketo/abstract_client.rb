module Marketo
  class AbstractClient
    include Marketo::Concerns::Base
    include Marketo::Concerns::Connection
    include Marketo::Concerns::Authentication
    include Marketo::Concerns::Caching
    include Marketo::Concerns::API
  end
end
