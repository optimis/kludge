require 'spec_helper'

describe Kludge::Parts do
  let(:parts) { Kludge::Parts.new }
  let(:trunk_val) { mock :trunk_val, :valid? => true }
  let(:branch_val) { mock :branch_val, :valid? => true }
  let(:leaves_val) { mock :leaves_val, :valid? => true }
  let(:trunk)  { Kludge::One.new(:trunk, :value => trunk_val) }
  let(:branch) { Kludge::One.new(:branch, :belongs_to => :trunk, :value => branch_val) }
  let(:leaves) { Kludge::Many.new(:leaves, :belongs_to => :branch, :value => [leaves_val]) }

  before { parts << branch << trunk << leaves }

  describe '#names' do
    it 'returns the names of all parts contained' do
      expect(parts.names).to eql([:branch, :trunk, :leaves])
    end
  end

  describe '#save' do
    it 'calls saves on all of its parts' do
      [branch_val, trunk_val, leaves_val].each { |part| part.should_receive(:save).once }
      parts.save
    end
  end

  describe '#valid?' do
    context 'all parts are valid' do
      it 'returns true if all of its parts return true' do
        expect(parts).to be_valid
      end
    end

    context 'any of its parts are not valid' do
      it 'returns false if any of its parts return false' do
        leaves_val.stub(:valid? => false, :errors => [])
        expect(parts).to_not be_valid
      end
    end
  end

  describe '#graph' do
    before { parts.graph }

    it 'sets parent and children for trunk' do
      expect(trunk.parent).to be_nil
      expect(trunk.children).to eql([branch])
    end

    it 'sets parent and children for branch' do
      expect(branch.parent).to eql(trunk)
      expect(branch.children).to eql([leaves])
    end

    it 'sets parent and children for leaves' do
      expect(leaves.parent).to eql(branch)
      expect(leaves.children).to be_empty
    end

    it 'returns roots of graph' do
      expect(parts.graph).to eql([trunk])
    end
  end

  describe '#leaves' do
    it 'returns branch' do
      expect(parts.leaves).to eql([leaves])
    end
  end
end
