module MarketoApi
  class Client < AbstractClient
    # Public: Returns a url to the resource.
    def url
      "#{instance_url}/rest/"
    end
  end
end
