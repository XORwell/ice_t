require 'spec_helper'

describe IceT::Rule::Repository do
  let(:repo) { IceT::Rule::Repository.new }
  let!(:rule_01) { IceT::Rule::Daily.new(1) }
  let!(:rule_02) { IceT::Rule::Daily.new(2) }
  let!(:rule_03) { IceT::Rule::Daily.new(3) }

  describe '#rules' do
    it "returns an array" do      
      expect(repo.rules).to be_an(Array)
    end
  end

  describe '#add' do
    it "adds a rule" do
      repo.add(rule_01)
      expect(repo.rules.size).to eql(1)
    end
  end

  describe '#remove' do
    before (:each) { 
      repo.add(rule_01) 
      repo.add(rule_03) 
      repo.add(rule_02)   
    }

    it "removes a rule" do
      repo.remove(rule_02)
      expect(repo.rules.last).to eql(rule_03)
    end
  end
end