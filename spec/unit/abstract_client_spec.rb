require 'spec_helper'

describe Marketo::AbstractClient do
  subject { described_class }

  it { should < Marketo::Concerns::Base }
  it { should < Marketo::Concerns::Connection }
  it { should < Marketo::Concerns::Authentication }
  it { should < Marketo::Concerns::Caching }

  it { should < Marketo::API::Base }
  it { should < Marketo::API::Leads }
  it { should < Marketo::API::Activities }
end
