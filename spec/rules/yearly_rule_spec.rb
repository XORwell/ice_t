require 'spec_helper'

describe IceT::Rule::Yearly do
  let(:klass) { IceT::Rule::Yearly }
  it_behaves_like "a rule"

  describe 'i18n' do
    let(:rule_01) { IceT::Rule::Yearly.new(1) }
    let(:rule_03) { IceT::Rule::Yearly.new(3) }
    context 'english' do
      before { I18n.locale = :en }
      it { expect(rule_01.to_s).to eql('yearly') }
      it { expect(rule_03.to_s).to eql('every 3 years') }
    end
    context 'german' do
      before { I18n.locale = :de }
      it { expect(rule_01.to_s).to eql('jährlich') }
      it { expect(rule_03.to_s).to eql('alle 3 Jahre') }
    end
  end  

end