require 'spec_helper'

describe Marketo do
  before do
    ENV['MARKETO_CLIENT_ID']      = nil
    ENV['MARKETO_CLIENT_SECRET']  = nil
    ENV['MARKETO_API_VERSION']    = nil
  end

  after do
    MarketoApi.instance_variable_set :@configuration, nil
  end

  describe '#configuration' do
    subject { MarketoApi.configuration }

    it { should be_a MarketoApi::Configuration }

    context 'by default' do
      its(:api_version)            { should eq '1' }
      its(:adapter)                { should eq Faraday.default_adapter }
      its(:ssl)                    { should eq({}) }
      [:client_id, :client_secret,
       :oauth_token, :instance_url, :timeout,
       :request_headers].each do |attr|
        its(attr) { should be_nil }
      end
    end

    context 'when environment variables are defined' do
      before do
        {
          'MARKETO_CLIENT_ID'      => 'client id',
          'MARKETO_CLIENT_SECRET'  => 'client secret',
          'MARKETO_API_VERSION'    => '37.0' }.
        each { |var, value| ENV.stub(:[]).with(var).and_return(value) }
      end

      its(:client_id)      { should eq 'client id' }
      its(:client_secret)  { should eq 'client secret' }
      its(:api_version)    { should eq '37.0' }
    end
  end

  describe '#configure' do
    [:client_id, :client_secret,
     :timeout, :oauth_token, :instance_url, :api_version,
     :ssl, :request_headers, :log_level, :logger].each do |attr|
      it "allows #{attr} to be set" do
        MarketoApi.configure do |config|
          config.send("#{attr}=", 'foobar')
        end
        expect(MarketoApi.configuration.send(attr)).to eq 'foobar'
      end
    end
  end

  describe '#log?' do
    subject { MarketoApi.log? }

    context 'by default' do
      it { should be_false }
    end
  end

  describe '#log' do
    context 'with logging disabled' do
      before do
        MarketoApi.stub log?: false
      end

      it 'doesnt log anytning' do
        MarketoApi.configuration.logger.should_not_receive(:debug)
        MarketoApi.log 'foobar'
      end
    end

    context 'with logging enabled' do
      before { MarketoApi.stub(log?: true) }

      it 'logs something' do
        MarketoApi.configuration.logger.should_receive(:debug).with('foobar')
        MarketoApi.log 'foobar'
      end

      context "with a custom logger" do
        let(:fake_logger) { double(debug: true) }

        before do
          MarketoApi.configure do |config|
            config.logger = fake_logger
          end
        end

        it "logs using the provided logger" do
          fake_logger.should_receive(:debug).with('foobar')
          MarketoApi.log('foobar')
        end
      end

      context "with a custom log_level" do
        before do
          MarketoApi.configure do |config|
            config.log_level = :info
          end
        end

        it 'logs with the provided log_level' do
          MarketoApi.configuration.logger.should_receive(:info).with('foobar')
          MarketoApi.log 'foobar'
        end
      end
    end
  end

  describe '.new' do
    it 'calls its block' do
      checker = double(:block_checker)
      expect(checker).to receive(:check!).once
      MarketoApi.new do |builder|
        checker.check!
      end
    end
  end
end
