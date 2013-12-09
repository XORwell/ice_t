shared_examples 'a rule' do  
  let(:rule){ klass.new(1) }
  
  describe '::to_i' do
    it { expect(klass).to respond_to(:to_i) }
  end
  describe '::unit' do
    it { expect(klass).to respond_to(:unit) }
  end

  describe '#occurrences' do
    it { expect(klass.new).to respond_to(:occurrences) }
    
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
    it { expect(klass).to respond_to(:from_json) }
    it { expect(klass.from_json(rule.to_json) == rule).to be_true }    
  end
  describe '::from_hash' do
    it { expect(klass).to respond_to(:from_hash) }    
    it { expect(klass.from_hash(rule.to_hash) == rule).to be_true }    
  end

  describe '::from_yaml' do
    it { expect(klass).to respond_to(:from_yaml) }    
    it { expect(klass.from_yaml(rule.to_yaml) == rule).to be_true }    
  end

  describe '#to_json' do
    it { expect(klass.new).to respond_to(:to_json) }
  end

  describe '#to_yaml' do
    it { expect(klass.new).to respond_to(:to_yaml) }
  end

  describe '#to_hash' do
    it { expect(klass.new).to respond_to(:to_hash) }
  end

end
