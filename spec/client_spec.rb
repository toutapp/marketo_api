require 'spec_helper'

describe MarketoApi::Client do
  subject { MarketoApi::Client.new }

  describe '#url' do
    it 'should return a url to the resource' do
      allow(subject).to receive(:instance_url).and_return('marketo_url')
      expect(subject.url).to eq('marketo_url/rest/')
    end
  end
end
