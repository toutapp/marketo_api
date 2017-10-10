require 'spec_helper'

describe MarketoApi::API::Sales do
  subject { Class.new.extend(MarketoApi::API::Sales) }

  describe '#best_bets' do
    it 'calls the sales/bestbets.json endpoint' do
      expect(subject).to receive(:api_get).with('sales/bestbets.json', {})
      subject.best_bets({})
    end
  end

  describe '#interesting_moments' do
    it 'calls the sales/interestingmoments.json endpoint' do
      expect(subject).to receive(:api_get).with('sales/interestingmoments.json', {})
      subject.interesting_moments({})
    end
  end

  describe '#create_activity!' do
    it 'calls the sales/activities.json endpoint' do
      expect(subject).to receive(:api_post).with('sales/activities.json', {})
      subject.create_activity!({})
    end
  end
end
