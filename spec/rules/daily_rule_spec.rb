require 'spec_helper'

describe IceT::Rule::Daily do
  let(:klass) { IceT::Rule::Daily }
  it_behaves_like "a rule"

  describe 'i18n' do
    let(:rule_daily_01) { IceT::Rule::Daily.new(1) }
    let(:rule_daily_03) { IceT::Rule::Daily.new(3) }
    context 'english' do
      I18n.locale = :en
      it { expect(rule_daily_01.to_s).to eql('daily') }
      it { expect(rule_daily_03.to_s).to eql('every 3 days') }
    end

    context 'german' do
      I18n.locale = :de
      it { expect(rule_daily_01.to_s).to eql('täglich') }
      it { expect(rule_daily_03.to_s).to eql('alle 3 Tage') }
    end
  end
end