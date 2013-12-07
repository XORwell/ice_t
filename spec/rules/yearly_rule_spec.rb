require 'spec_helper'

describe IceT::Rule::Yearly do
  let(:klass) { IceT::Rule::Yearly }
  it_behaves_like "a rule"
end