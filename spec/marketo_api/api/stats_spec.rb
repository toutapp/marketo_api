require 'spec_helper'

describe MarketoApi::API::Stats do
  subject { Class.new.extend(MarketoApi::API::Stats) }

  describe '#daily_usage' do
    it 'calls the stats/usage.json endpoint' do
      expect(subject).to receive(:api_get).with('stats/usage.json')
      subject.daily_usage
    end
  end

  describe '#daily_errors' do
    it 'calls the stats/errors.json endpoint' do
      expect(subject).to receive(:api_get).with('stats/errors.json')
      subject.daily_errors
    end
  end

  describe '#weekly_usage' do
    it 'calls the stats/usage/last7days.json endpoint' do
      expect(subject).to receive(:api_get).with('stats/usage/last7days.json')
      subject.weekly_usage
    end
  end

  describe '#weekly_errors' do
    it 'calls the stats/errors/last7days.json endpoint' do
      expect(subject).to receive(:api_get).with('stats/errors/last7days.json')
      subject.weekly_errors
    end
  end
end
