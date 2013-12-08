require 'spec_helper'

describe IceT::Rule::Hourly do
  let(:klass) { IceT::Rule::Hourly }
  it_behaves_like "a rule"
end