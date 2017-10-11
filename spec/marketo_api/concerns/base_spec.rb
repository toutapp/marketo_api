require 'spec_helper'

describe MarketoApi::Concerns::Base do
  subject do
    class Foo
      include MarketoApi::Concerns::Base
    end
  end

  describe '.new' do
    it 'raises when exception when the opts is not a hash' do
      expect{ subject.new([]) }.to raise_error(ArgumentError, 'Please specify a hash of options')
    end
  end
end
