require 'spec_helper'

describe MarketoApi do
  it 'should return a version' do
    expect(MarketoApi::VERSION).to eq('0.3.0-alpha')
  end
end
