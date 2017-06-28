require 'spec_helper'

describe Marketo::Client do
  subject { described_class }

  it { should < Marketo::AbstractClient }
end
