require 'spec_helper'

describe IceT::Rule::Minutely do
  let(:klass) { IceT::Rule::Minutely }
  it_behaves_like "a rule"

  describe 'i18n' do
    let(:rule_01) { IceT::Rule::Minutely.new(1) }
    let(:rule_03) { IceT::Rule::Minutely.new(3) }
    context 'english' do
      before { I18n.locale = :en }
      it { expect(rule_01.to_s).to eql('minutely') }
      it { expect(rule_03.to_s).to eql('every 3 minutes') }
    end
    context 'german' do
      before { I18n.locale = :de }
      it { expect(rule_01.to_s).to eql('minütlich') }
      it { expect(rule_03.to_s).to eql('alle 3 Minuten') }
    end
  end

end