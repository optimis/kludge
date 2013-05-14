require 'spec_helper'

describe Kludge::One do
  describe '#errors' do
    class Trunk
      extend ActiveModel::Naming
    end
    let(:trunk) { Trunk.new }
    let(:errors) { ActiveModel::Errors.new(trunk).tap { |errors| errors.add(:name, "can't be blank") } }

    before do
      trunk.stub(:invalid? => true, :valid? => false, :errors => errors)
    end
    
    it 'returns the errors of its underlying value' do
      one = Kludge::One.new(:trunk, :value => trunk)
      expect(one).to_not be_valid
      expect(one.errors.full_messages).to eql(["Name can't be blank"])
    end
  end
end
