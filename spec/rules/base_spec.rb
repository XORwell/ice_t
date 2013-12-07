require 'spec_helper'

describe IceT::Rule::Base do

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

end