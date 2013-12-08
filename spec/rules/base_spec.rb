require 'spec_helper'

describe IceT::Rule::Base do

  describe 'descendants comparison' do
    classes = IceT::Rule::Base.descendants.sort
    classes.each_with_index { | obj, i |
      describe "#{obj}" do
        classes.each_with_index { | other, j |
          case 
          when i == j
            it "#{obj} == #{other}" do
              expect(obj==other).to be_true
            end
            it "#{obj}.new(1) == #{other}.new(1)" do
              expect(obj.new(1) == other.new(1)).to be_true
            end
            it "#{obj}.new(1) < #{other}.new(2)" do
              expect(obj.new(1) < other.new(2)).to be_true
            end
            it "#{obj}.new(2) > #{other}.new(1)" do
              expect(obj.new(2) > other.new(1)).to be_true
            end
            it "#{obj}.new(1) <= #{other}.new(1)" do
              expect(obj.new(1) <= other.new(1)).to be_true
            end
            it "#{obj}.new(1) >= #{other}.new(1)" do
              expect(obj.new(1) >= other.new(1)).to be_true
            end            
          when i > j
            it "#{obj} > #{other} is true" do
              expect(obj > other).to be_true
            end
            it "#{obj} < #{other} is false" do
              expect(obj < other).to be_false
            end
            it "#{obj} == #{other} is false" do
              expect(obj == other).to be_false
            end
            it "#{obj}.new(1) > #{other}.new(1) is true" do
              expect(obj.new(1) > other.new(1)).to be_true
            end
            it "#{obj}.new(1) < #{other}.new(1) is false" do
              expect(obj.new(1) < other.new(1)).to be_false
            end
            it "#{obj}.new(1) == #{other}.new(1) is false" do
              expect(obj.new(1) == other.new(1)).to be_false
            end
          when i < j
            it "#{obj} < #{other} is true" do
              expect(obj < other).to be_true
            end            
            it "#{obj} > #{other} is false" do
              expect(obj > other).to be_false
            end            
            it "#{obj} == #{other} is false" do
              expect(obj == other).to be_false
            end            
            it "#{obj}.new(1) < #{other}.new(1)" do
              expect(obj.new(1) < other.new(1)).to be_true
            end            
          end
        }        
      end
    }

    subject { IceT::Rule::Daily.new(1) }
    it { expect{subject < "a"}.to raise_error }
    it { expect{subject > 1}.to raise_error }
  end


  describe '.new' do
    describe 'param: interval' do
      context 'when valid' do
        it { expect{subject.class.new(1)}.not_to raise_error }
        it { expect{subject.class.new()}.not_to raise_error }
      end
      context 'when invalid' do
        it { expect{subject.class.new(-1)}.to raise_error }
        it { expect{subject.class.new(1.2)}.to raise_error }
        it { expect{subject.class.new("a")}.to raise_error }
      end  
    end

    describe 'param: at' do
      context 'when valid' do
        it { expect{subject.class.new(1, "4pm")}.not_to raise_error }
        it { expect{subject.class.new(1, nil)}.not_to raise_error }
      end
      context 'when invalid' do
        it { expect{subject.class.new(1, "")}.to raise_error }
        it { expect{subject.class.new(1, -1)}.to raise_error }
        it { expect{subject.class.new(1, "a")}.to raise_error }
      end
    end
  end  

  context 'respond_to?' do
    operators = ['==', '<', '>', '<=', '>=']
    operators.each{ |operator|
      describe operator do
        it { expect(subject.class.new.respond_to?(operator.to_sym)).to be_true }  
      end
    }
  end

  describe '.from_yaml' do
    let(:rule) { IceT::Rule::Daily.new(42) }
    let(:yaml) { rule.to_yaml }
    it { expect(IceT::Rule::Daily.from_yaml(yaml) == rule ).to be_true }
  end

end