require 'spec_helper'

describe MarketoApi::Concerns::Connection do
  describe '.middleware' do
    subject       { client.middleware }
    let(:builder) { double('Faraday::Builder') }

    before do
      client.stub_chain :connection, builder: builder
    end

    it { should eq builder }
  end

  describe "#connection_options" do
    let(:options) { { ssl: { verify: false } } }
    before { client.stub(options: options) }

    it "picks up passed-in SSL options" do
      expect(client.send(:connection_options)).to include(options)
    end
  end

  describe 'private #connection' do
    describe ":logger option" do
      let(:options) { { adapter: Faraday.default_adapter } }

      before(:each) do
        client.stub(:authentication_middleware)
        client.stub(:cache)
        client.stub(options: options)
        MarketoApi.stub(log?: true)
      end

      it "must always be used last before the Faraday Adapter" do
        client.middleware.handlers.reverse.index(MarketoApi::Middleware::Logger).
          should eq 1
      end
    end
  end

  describe '#adapter' do
    before do
      client.stub options: { adapter: :typhoeus }
    end

    its(:adapter) { should eq(:typhoeus) }
  end
end
