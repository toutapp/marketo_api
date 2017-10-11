require 'spec_helper'

describe MarketoApi::Concerns::Base do
  let(:klass) do
    class Foo
      include MarketoApi::Concerns::Base
    end
  end

  describe '.new' do
    it 'raises when exception when the opts is not a hash' do
      expect{ klass.new([]) }.to raise_error(ArgumentError, 'Please specify a hash of options')
    end
  end

  describe '#instance_url' do
    context 'when an instance url is present' do
      let(:obj) { klass.new({ instance_url: 'http://example.com' }) }

      it 'returns the url' do
        expect(obj).not_to receive(:authenticate!)
        expect(obj.instance_url).to eql('http://example.com')
      end
    end

    context 'when an instance url is missing' do
      let(:obj) { klass.new({}) }

      it 'calls authenticate!' do
        expect(obj).to receive(:authenticate!)
        obj.instance_url
      end
    end
  end

  describe '#inspect' do
    let(:obj) { klass.new({}) }

    it 'returns a string representation of the obj' do
      expect(obj.inspect).to include('#<Foo @options=')
    end
  end
end
