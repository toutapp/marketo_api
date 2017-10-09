require 'spec_helper'

describe MarketoApi::API::Leads do
  subject { Class.new.extend(MarketoApi::API::Leads) }

  describe '#leads_describe' do
    it 'calls the leads/describe.json endpoint' do
      expect(subject).to receive(:api_get).with('leads/describe.json')
      subject.leads_describe
    end
  end

  describe '#leads_by_id' do
    it 'calls the leads/1337.json endpoint' do
      expect(subject).to receive(:api_get).with('leads/1337.json')
      subject.leads_by_id(1337)
    end
  end

  describe '#leads_by_filter_type' do
    it 'calls the leads.json?filterType=foo&filterValues=one,two endpoint' do
      expect(subject).to receive(:api_get).with('leads.json?filterType=foo&filterValues=one,two')
      subject.leads_by_filter_type('foo', ['one', 'two'])
    end
  end
end
