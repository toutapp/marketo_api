require 'spec_helper'

describe MarketoApi::Concerns::Verbs do
  let(:klass) do
    class Foo
      extend MarketoApi::Concerns::Verbs
    end
  end

  describe '#define_verbs' do
    let(:conn_mock) { double('connection') }
    let(:obj) { klass.new }

    it 'creates a verb method and an api method' do
      klass.define_verbs(:get)

      expect(obj).to receive(:connection).and_return(conn_mock)
      expect(conn_mock).to receive(:send).with(:get)
      obj.get
    end
  end
end
