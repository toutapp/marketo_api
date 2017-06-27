require 'spec_helper'

describe MarketoApi::API::Activities do
  subject { Class.new.extend(MarketoApi::API::Activities) }

  describe '#activities_describe' do
    it 'calls the activities/types.json endpoint' do
      expect(subject).to receive(:api_get).with('activities/types.json')
      subject.activities_describe
    end
  end

  describe '#paging_token' do
    context 'when start_time is nil' do
      let(:current_time) { Time.now }
      let(:current_time_iso) { current_time.iso8601 }

      before { allow(Time).to receive(:now).and_return(current_time) }

      it 'calls the endpoint activities/pagingtoken.json?sinceDatetime' do
        expect(subject).to receive(:api_get).with("activities/pagingtoken.json?sinceDatetime=#{current_time_iso}")
        subject.paging_token(nil)
      end
    end

    context 'when start_time is present' do
      it 'calls the endpoint activities/pagingtoken.json?sinceDatetime' do
        current_time = Time.now
        current_time_iso = current_time.iso8601

        expect(subject).to receive(:api_get).with("activities/pagingtoken.json?sinceDatetime=#{current_time_iso}")
        subject.paging_token(current_time)
      end
    end
  end

  describe '#add_next_page_token' do
    it 'appends nextPageToken to the path' do
      expect(subject.add_next_page_token('foo', 'bar')).to eql('foo&nextPageToken=bar')
    end
  end

  describe '#add_activity_type_ids' do
    context 'when type_ids are passed in' do
      it 'appends activityTypeIds' do
        expect(subject.add_activity_type_ids([1, 2, 3])).to eql('activityTypeIds=1,2,3')
      end
    end

    context 'when type_ids are not passed in' do
      it 'does not append activityTypeIds' do
        expect(subject.add_activity_type_ids(nil)).to be_empty
      end
    end
  end

  describe '#activities_by_lead_ids' do
    it 'calls activities.json endpoint' do
      expect(subject).to receive(:api_get).with('activities.json?leadIds=1,2,3&activityTypeIds=1,2,3')
      subject.activities_by_lead_ids([1,2,3], [1,2,3])
    end
  end

  describe '#activities_by_type_id' do
    it 'calls activities.json endpoint' do
      expect(subject).to receive(:api_get).with('activities.json?activityTypeIds=1,2,3')
      subject.activities_by_type_id([1,2,3])
    end
  end
end
