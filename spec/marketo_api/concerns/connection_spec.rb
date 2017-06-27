require 'spec_helper'

describe MarketoApi::Concerns::Connection do
  subject { Class.new.extend(MarketoApi::Concerns::Connection) }

  describe '#middleware' do
    let(:connection_mock) { double('faraday') }

    it 'creates a connection' do
      expect(subject).to receive(:connection).and_return(connection_mock)
      expect(connection_mock).to receive(:builder)
      subject.middleware
    end
  end
end
