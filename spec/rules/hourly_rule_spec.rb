require 'spec_helper'

describe IceT::Rule::Hourly do
  let(:klass) { IceT::Rule::Hourly }
  it_behaves_like "a rule"

  describe 'i18n' do
    let(:rule_01) { IceT::Rule::Hourly.new(1) }
    let(:rule_03) { IceT::Rule::Hourly.new(3) }
    context 'english' do
      before { I18n.locale = :en }
      it { expect(rule_01.to_s).to eql('hourly') }
      it { expect(rule_03.to_s).to eql('every 3 hours') }
    end
    context 'german' do
      before { I18n.locale = :de }
      it { expect(rule_01.to_s).to eql('stündlich') }
      it { expect(rule_03.to_s).to eql('alle 3 Stunden') }
    end
  end

end