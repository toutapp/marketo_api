module ClientIntegrationExampleGroup
  def self.included(base)
    base.class_eval do
      let(:oauth_token) do
        '00Dx0000000BV7z!AR8AQAxo9UfVkh8AlV0Gomt9Czx9LjHnSSpwBMmbRcgKFmxOtvxjTrKW19ye6P' \
        'E3Ds1eQz3z8jr3W7_VbWmEu4Q8TVGSTHxs'
      end

      let(:instance_url)   { 'https://na1.marketo.com' }
      let(:client_id)      { 'client_id'      }
      let(:client_secret)  { 'client_secret'  }
      let(:cache)          { nil }

      let(:base_options) do
        {
          oauth_token: oauth_token,
          instance_url: instance_url,
          client_id: client_id,
          client_secret: client_secret,
          cache: cache,
          request_headers: { 'x-test-header' => 'Test Header' }
        }
      end

      let(:client_options) { base_options }

      subject(:client) { described_class.new client_options }
    end
  end

  RSpec.configure do |config|
    config.include self,
                   example_group: {
                     describes: lambda do |described|
                       described <= Marketo::AbstractClient
                     end,
                     file_path: %r{spec/integration}
                   }
  end
end
