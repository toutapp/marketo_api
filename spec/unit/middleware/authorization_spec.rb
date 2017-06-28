require 'spec_helper'

describe Marketo::Middleware::Authorization do
  let(:options) { { oauth_token: 'token' } }

  describe '.call' do
    subject { lambda { middleware.call(env) } }

    it { should change { env[:request_headers]['Authorization'] }.to eq 'Bearer token' }
  end
end
