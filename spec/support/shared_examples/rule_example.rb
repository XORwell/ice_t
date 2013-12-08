shared_examples 'a rule' do  
  
  describe '::to_i' do
    it { expect(klass).to respond_to(:to_i) }
  end
  describe '::unit' do
    it { expect(klass).to respond_to(:unit) }
  end

  describe '#occurrences' do
    it { expect(klass.new).to respond_to(:occurrences) }
    
    let(:rule){ klass.new(1) }
    let(:start_time){ Time.now }
    let(:duration){ eval("2.#{klass.unit}") }
    let(:end_time){ start_time + duration }
    subject { rule.occurrences(start_time, start_time + duration) }
    
    it 'does contain the start_time' do
      expect(subject.first).to eql(start_time)
    end
    it 'does contain the end_time' do
      expect(subject.last).to eql(end_time)
    end
  end

  describe '::from_json' do
    pending
    #it { expect(klass).to respond_to(:from_json) }    
  end

  describe '::from_yaml' do
    pending
    #it { expect(klass).to respond_to(:from_yaml) }    
  end

  describe '#to_json' do
    it { expect(klass.new).to respond_to(:to_json) }
  end

  describe '#to_yaml' do
    it { expect(klass.new).to respond_to(:to_yaml) }
  end

  describe '#@at' do
    it {expect(klass.new(1, "4pm").at).to eql("4pm")}
  end


  describe 'comparison' do
    classes = IceT::Rule::Base.descendants.sort
    classes.each_with_index { | obj, i |
      classes.each_with_index { | other, j |
        case 
        when i == j
          context 'on class level' do
            it "#{obj} == #{other}" do
              expect(obj==other).to be_true
            end
          end
          context 'on instance level' do
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
          end
        when i > j
          context 'on class level' do
            it "#{obj} > #{other}" do
              expect(obj > other).to be_true
            end
          end
          context 'on instance level' do
            it "#{obj}.new(1) > #{other}.new(1)" do
              expect(obj.new(1) > other.new(1)).to be_true
            end
          end
        when i < j
          context 'on class level' do
            it "#{obj} < #{other}" do
              expect(obj < other).to be_true
            end            
          end
          context 'on instance level' do
            it "#{obj}.new(1) < #{other}.new(1)" do
              expect(obj.new(1) < other.new(1)).to be_true
            end            
          end
        end
      }        
    }
  end

end
