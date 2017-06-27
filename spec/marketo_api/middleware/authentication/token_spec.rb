require 'spec_helper'

describe MarketoApi::Middleware::Authentication::Token do
  subject do
    MarketoApi::Middleware::Authentication::Token.new(double, double, {
      client_id: 'client_id_x',
      client_secret: 'client_secret_x'
    })
  end

  describe '#params' do
    it 'returns the params' do
      expect(subject.params).to eql({
        grant_type: 'client_credentials',
        client_id: 'client_id_x',
        client_secret: 'client_secret_x'
      })
    end
  end
end
