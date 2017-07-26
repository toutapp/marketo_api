require 'spec_helper'

describe MarketoApi::AbstractClient do
  subject { described_class }

  it { should < MarketoApi::Concerns::Base }
  it { should < MarketoApi::Concerns::Connection }
  it { should < MarketoApi::Concerns::Authentication }
  it { should < MarketoApi::Concerns::Caching }

  it { should < MarketoApi::API::Base }
  it { should < MarketoApi::API::Leads }
  it { should < MarketoApi::API::Activities }
end
