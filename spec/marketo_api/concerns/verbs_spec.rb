require 'spec_helper'

describe MarketoApi::Concerns::Verbs do
  subject { Class.new.extend(MarketoApi::Concerns::Verbs) }

  describe '#define_verbs' do
    xit 'creates a verb method and an api method' do
      expect{ subject.get }.not_to raise_error
      subject.define_verbs(:get, :post)
    end
  end

  describe '#define_verb' do

  end

  describe '#define_api_verb' do

  end
end
