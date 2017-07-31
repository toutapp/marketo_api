require 'spec_helper'

describe MarketoApi::Client do
  subject { described_class }

  it { should < MarketoApi::AbstractClient }
end
