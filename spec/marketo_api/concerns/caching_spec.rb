require 'spec_helper'

describe MarketoApi::Concerns::Caching do
  subject { Class.new.extend(MarketoApi::Concerns::Caching) }

  describe '#without_caching' do
    let(:blk) { lambda{} }

    before do
      allow(subject).to receive(:options).and_return({})
    end

    it 'calls the passed in block' do
      expect(blk).to receive(:call)
      subject.without_caching(&blk)
    end
  end
end
