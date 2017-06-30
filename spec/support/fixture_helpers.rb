module FixtureHelpers
  module InstanceMethods
    def stub_api_request(endpoint, options = {})
      options = {
        method: :get,
        status: 200,
        api_version: Marketo.configuration.api_version
      }.merge(options)

      stub = stub_request(options[:method],
                          %r{/services/data/v#{options[:api_version]}/#{endpoint}})

      if options[:fixture]
        stub = stub.to_return(status: options[:status],
                              body: fixture(options[:fixture]),
                              headers: { 'Content-Type' => 'application/json' })
      end

      stub
    end

    def stub_login_request(*)
      grant_type = "grant_type=client_credentials"
      params = "client_id=client_id&client_secret=client_secret&#{grant_type}"
      url = "https://login.marketo.com/identity/oauth/token"
      stub = stub_request(:get, "#{url}?#{params}")

      stub
    end

    def fixture(f)
      File.read(File.expand_path("../../fixtures/#{f}.json", __FILE__))
    end
  end

  module ClassMethods
    def requests(endpoint, options = {})
      before do
        (@requests ||= []) << stub_api_request(endpoint, options)
      end

      after do
        @requests.each { |request| expect(request).to have_been_requested }
      end
    end
  end
end

RSpec.configure do |config|
  config.include FixtureHelpers::InstanceMethods
  config.extend FixtureHelpers::ClassMethods
end
