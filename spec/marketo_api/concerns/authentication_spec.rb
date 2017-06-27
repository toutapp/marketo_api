require 'spec_helper'

describe MarketoApi::Concerns::Authentication do
  subject { Class.new.extend(MarketoApi::Concerns::Authentication) }

  describe '#authenticate!' do
    context 'when no authentication middleware is present' do
      before { allow(subject).to receive(:authentication_middleware).and_return(false) }

      it 'raises an error' do
        expect{ subject.authenticate! }.to raise_error(MarketoApi::AuthenticationError, 'No authentication middleware present')
      end
    end

    context 'when an authentication middleware is present' do
      let(:middleware_mock) { double('authentication_middleware') }

      before { allow(subject).to receive(:options) }

      it 'authenticates the middleware' do
        expect(MarketoApi::Middleware::Authentication::Token).to receive(:new).and_return(middleware_mock)
        expect(middleware_mock).to receive(:authenticate!)
        subject.authenticate!
      end
    end
  end

  describe '#authentication_middleware' do
    it 'returns MarketoApi::Middleware::Authentication::Token' do
      expect(subject.authentication_middleware).to eql(MarketoApi::Middleware::Authentication::Token)
    end
  end
end
