require 'spec_helper'

describe IceT::Schedule do 
  let!(:start_time) { Time.now }
  let!(:end_time) { Time.now + 2.months }
  let!(:schedule) { IceT::Schedule.new(start_time: start_time, end_time: end_time) }
  let!(:daily_rule) { IceT::Rule::Daily.new(1) }
  let!(:monthly_rule) { IceT::Rule::Monthly.new(1) }
  let(:repo) { schedule.instance_variable_get(:@rules) }

  describe '#add_rule' do
    it "delegates to repository.add" do
      expect(repo).to receive(:add).with(daily_rule)
      schedule.add_rule(daily_rule)
    end
  end

  describe '#remove_rule' do
    it "delegates to repository.remove" do
      expect(repo).to receive(:remove).with(daily_rule)
      schedule.remove_rule(daily_rule)
    end
  end

  describe '#rules' do
    it "delegates to repository.rules" do
      expect(repo).to receive(:rules)
      schedule.rules
    end
  end

  describe '#to_json' do
    it { expect(subject).to respond_to(:to_json) }
    it { expect(subject.to_json).to be_an(String) }
  end
  
  describe '#to_yaml' do
    it { expect(subject).to respond_to(:to_yaml) }
    it { expect(subject.to_json).to be_an(String) }
  end

  describe '::from_json' do
    context "the created object" do
      before do
        schedule.add_rule(daily_rule)
        schedule.add_rule(monthly_rule)      
      end
      let(:json) { schedule.to_json }
      let(:object) { IceT::Schedule.from_json(json) }

      it "is a Schedule" do
        expect(object).to be_an(IceT::Schedule)
      end
      it "contains the same rules as before" do
        expect(object.rules.map(&:to_json)).to eql(schedule.rules.map(&:to_json))
      end

      [:start_time, :end_time].each { |time|
        it "does have the same #{time} as before" do
          expect(object.send(time).to_i).to eql(eval("#{time}").to_i)
        end
      }

    end
  end
  
  describe '::from_yaml' do
    pending
  end

end 