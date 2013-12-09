require 'spec_helper'

describe IceT::Rule::Secondly do
  let(:klass) { IceT::Rule::Secondly }
  it_behaves_like "a rule"
  
  describe 'i18n' do
    let(:rule_01) { IceT::Rule::Secondly.new(1) }
    let(:rule_03) { IceT::Rule::Secondly.new(3) }
    context 'english' do
      before { I18n.locale = :en }
      it { expect(rule_01.to_s).to eql('secondly') }
      it { expect(rule_03.to_s).to eql('every 3 seconds') }
    end
    context 'german' do
      before { I18n.locale = :de }
      it { expect(rule_01.to_s).to eql('sekündlich') }
      it { expect(rule_03.to_s).to eql('alle 3 Sekunden') }
    end
  end  

end