require 'spec_helper'

describe IceT::Rule::Monthly do
  let(:klass) { IceT::Rule::Monthly }
  it_behaves_like "a rule"  

  describe 'i18n' do
    let(:rule_01) { IceT::Rule::Monthly.new(1) }
    let(:rule_03) { IceT::Rule::Monthly.new(3) }
    context 'english' do
      before { I18n.locale = :en }
      it { expect(rule_01.to_s).to eql('monthly') }
      it { expect(rule_03.to_s).to eql('every 3 months') }
    end
    context 'german' do
      before { I18n.locale = :de }
      it { expect(rule_01.to_s).to eql('monatlich') }
      it { expect(rule_03.to_s).to eql('alle 3 Monate') }
    end
  end

end