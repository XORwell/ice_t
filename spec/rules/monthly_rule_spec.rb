require 'spec_helper'

describe IceT::Rule::Monthly do

  let(:klass) { IceT::Rule::Monthly }
  it_behaves_like "a rule"


  let!(:interval) { 1 }
  let!(:start_time) { 1.year.ago }
  let!(:end_time) { Time.now }
  let(:rule) { IceT::Rule::Monthly.new(interval) }

  # it_behaves_like "a comparable rule" do
  #   let(:small_rule) { IceT::Rule::Monthly.new(1) }
  #   let(:big_rule) { IceT::Rule::Monthly.new(2) }
  # end


  describe "#occurrences" do
    
    subject { rule.occurrences(start_time, end_time) }

    it "returns an array" do
      expect(subject).to be_an(Array)
    end

    context "one year ago until now" do
      it "returns an array with 12 elements" do
        expect(subject.size).to eql(12) 
      end
      it "contains end_time as last element" do
        expect(subject.last.to_date).to eql(end_time.to_date)
      end
    end

  end
  
  describe "::from_yaml" do
    pending
  end
  
  describe "::from_json" do
    pending
  end

end