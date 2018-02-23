require 'spec_helper'

describe MarketoApi::API::Workspaces do
  subject { Class.new.extend(MarketoApi::API::Workspaces) }

  describe '#user_workspaces' do
    it 'calls the userservice/lm/v1/workspaces' do
      expect(subject).to receive(:get).with('userservice/lm/v1/workspaces/')
      subject.user_workspaces
    end
  end
end
