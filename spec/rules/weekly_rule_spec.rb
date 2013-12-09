require 'spec_helper'

describe IceT::Rule::Weekly do
  let(:klass) { IceT::Rule::Weekly }
  it_behaves_like "a rule"

  describe 'i18n' do
    let(:rule_01) { IceT::Rule::Weekly.new(1) }
    let(:rule_03) { IceT::Rule::Weekly.new(3) }
    context 'english' do
      before { I18n.locale = :en }
      it { expect(rule_01.to_s).to eql('weekly') }
      it { expect(rule_03.to_s).to eql('every 3 weeks') }
    end
    context 'german' do
      before { I18n.locale = :de }
      it { expect(rule_01.to_s).to eql('wöchentlich') }
      it { expect(rule_03.to_s).to eql('alle 3 Wochen') }
    end
  end  

end