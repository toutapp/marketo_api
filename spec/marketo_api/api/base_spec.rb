require 'spec_helper'

describe MarketoApi::API::Base do
  subject { Class.new.extend(MarketoApi::API::Base) }

  describe '#format_filter_values' do
    context 'when filter_values is a hash' do
      it 'formats the filter_values' do
        expect(subject.format_filter_values({ foo: 'bar' })).to eql({ foo: 'bar' })
      end
    end

    context 'when filter_values is an array' do
      it 'formats the filter_values' do
        expect(subject.format_filter_values(['foo', 'bar'])).to eql('foo,bar')
      end
    end
  end
end
