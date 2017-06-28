require 'spec_helper'

describe Marketo::AbstractClient do
  subject { described_class }

  it { should < Marketo::Concerns::Base }
  it { should < Marketo::Concerns::Connection }
  it { should < Marketo::Concerns::Authentication }
  it { should < Marketo::Concerns::Caching }
  it { should < Marketo::Concerns::API }
end
