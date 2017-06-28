require 'spec_helper'

describe Marketo::Middleware::Authentication do
  let(:options) do
    { host: 'login.marketo.com',
      proxy_uri: 'https://not-a-real-site.com',
      authentication_retries: retries,
      adapter: :net_http,
      ssl: { version: :TLSv1_2 } }
  end

  describe '.authenticate!' do
    subject { lambda { middleware.authenticate! } }
    it      { should raise_error NotImplementedError }
  end

  describe '.call' do
    subject { lambda { middleware.call(env) } }

    context 'when successfull' do
      before do
        app.should_receive(:call).once
      end

      it { should_not raise_error }
    end

    context 'when an exception is thrown' do
      before do
        env.stub body: 'foo', request: { proxy: nil }
        middleware.stub :authenticate!
        app.should_receive(:call).once.
          and_raise(Marketo::UnauthorizedError.new('something bad'))
      end

      it { should raise_error Marketo::UnauthorizedError }
    end
  end

  describe '.connection' do
    subject(:connection) { middleware.connection }

    its(:url_prefix)     { should eq(URI.parse('https://login.marketo.com')) }

    it "should have a proxy URI" do
      connection.proxy[:uri].should eq(URI.parse('https://not-a-real-site.com'))
    end

    describe '.builder' do
      subject(:builder) { connection.builder }

      context 'with logging disabled' do
        before do
          Marketo.stub log?: false
        end

        its(:handlers) {
          should include FaradayMiddleware::ParseJson,
                         Faraday::Adapter::NetHttp
        }
        its(:handlers) { should_not include Marketo::Middleware::Logger  }
      end

      context 'with logging enabled' do
        before do
          Marketo.stub log?: true
        end

        its(:handlers) {
          should include FaradayMiddleware::ParseJson,
                         Marketo::Middleware::Logger, Faraday::Adapter::NetHttp
        }
      end

      context 'with specified adapter' do
        before do
          options[:adapter] = :typhoeus
        end

        its(:handlers) {
          should include FaradayMiddleware::ParseJson, Faraday::Adapter::Typhoeus
        }
      end
    end

    it "should have SSL config set" do
      connection.ssl[:version].should eq(:TLSv1_2)
    end
  end
end
