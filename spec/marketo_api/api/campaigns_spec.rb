require 'spec_helper'

describe MarketoApi::API::Campaigns do
  subject { Class.new.extend(MarketoApi::API::Campaigns) }

  describe '#campaign_by_id' do
    it 'calls the campaigns/1337.json endpoint' do
      campaign_id = 1337

      expect(subject).to receive(:api_get).with("campaigns/#{campaign_id}.json")

      subject.campaign_by_id(campaign_id)
    end
  end

  describe '#campaigns_by_workspace' do
    it 'calls #campaigns with default workspace' do
      options = { workspaceName: 'Default' }

      expect(subject).to receive(:campaigns).with(options)

      subject.campaigns_by_workspace
    end

    it 'calls #campaigns with workspace' do
      workspace_name = 'foo'
      options = { bar: 'baz' }

      expect(subject).
        to receive(:campaigns).
        with({ workspaceName: workspace_name }.merge(options))

      subject.campaigns_by_workspace(workspace_name, options)
    end
  end

  describe '#campaigns_next_page' do
    it 'calls #campaigns with next page token' do
      options = { foo: 'bar' }
      next_page_token = 'baz'
      next_page_token_param = { nextPage: next_page_token }

      expect(subject).
        to receive(:paging_token_param).
        with(next_page_token).
        and_return(next_page_token_param)
      expect(subject).
        to receive(:campaigns).
        with(options.merge(next_page_token_param))

      subject.campaigns_next_page(next_page_token, options)
    end
  end

  describe '#campaigns' do
    it 'should call campaigns.json with query params' do
      options = { foo: 'bar' }
      options_query = 'foo=bar'

      expect(subject).
        to receive(:to_query).
        with(options).
        and_return(options_query)
      expect(subject).
        to receive(:api_get).
        with("campaigns.json?#{options_query}")

      subject.campaigns(options)
    end
  end

  describe '#trigger_campaign!' do
    it 'calls the campaigns/1337.json endpoint' do
      campaign_id = 1337
      attrs = { foo: 'bar' }

      expect(subject).to receive(:api_post).with(
        "campaigns/#{campaign_id}/trigger.json",
        attrs
      )

      subject.trigger_campaign!(campaign_id, attrs)
    end
  end
end

