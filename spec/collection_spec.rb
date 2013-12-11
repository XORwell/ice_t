require 'spec_helper'

describe IceT::Collection do 
  
  let!(:daily_rule_01) { IceT::Rule::Daily.new(1) }
  let!(:daily_rule_02) { IceT::Rule::Daily.new(2) }
  
  describe '#add_rule' do
    it { expect(subject).to respond_to(:add_rule) }
  
    before do
      subject.add_rule daily_rule_01
    end
    context 'after adding one rule the size' do
      it { expect(subject.rules.size).to eql(1) }
    end
    it 'does not add same rule twice' do
      subject.add_rule daily_rule_01
      expect(subject.rules.size).to eql(1)
    end
  end
  
  describe '#remove_rule' do
    it { expect(subject).to respond_to(:remove_rule) }
    
    before do
      subject.add_rule daily_rule_01
      subject.add_rule daily_rule_02
    end

    context 'when removing a rule' do
      before do
        subject.remove_rule(daily_rule_01)
      end
      it "does remove the right rule" do
        expect(subject.rules).to_not include(daily_rule_01)
      end
      it "does not remove the other rule" do
        expect(subject.rules).to include(daily_rule_02)
      end
    end

  end
  
  describe 'weekday methods' do
    IceT::TimeHelper::PLURALIZED_DAYNAMES.each { |wday|
      it { expect(subject).to respond_to(wday.to_sym) }
      describe wday do
        coll = IceT::Collection.new
        coll.add_rule IceT::Rule::Daily.new(1)      
        times = coll.send(wday, 1.week.ago, Time.now)
        times.each { |t|
          meth = IceT::TimeHelper.question_mark_dayname(wday)
          it "returns #{t} - which is #{t.strftime("%^A")}" do
            expect(t.send(meth)).to be_true
          end
        }
      end
    }
  end
end