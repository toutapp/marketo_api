require 'spec_helper'

describe Marketo::Concerns::Authentication do
  describe '.authenticate!' do
    subject(:authenticate!) { client.authenticate! }

    context 'when there is no authentication middleware' do
      before do
        client.stub authentication_middleware: nil
      end

      it "raises an error" do
        expect { authenticate! }.to raise_error Marketo::AuthenticationError,
                                                'No authentication middleware present'
      end
    end

    context 'when there is authentication middleware' do
      let(:authentication_middleware) { double('Authentication Middleware') }
      subject(:result) { client.authenticate! }

      it 'authenticates using the middleware' do
        client.stub authentication_middleware: authentication_middleware
        client.stub :options
        authentication_middleware.
          should_receive(:new).
          with(nil, client, client.options).
          and_return(double(authenticate!: 'foo'))
        expect(result).to eq 'foo'
      end
    end
  end

  describe '.authentication_middleware' do
    subject { client.authentication_middleware }

    context 'when oauth options are provided' do
      it { should eq Marketo::Middleware::Authentication::Token }
    end
  end
end
