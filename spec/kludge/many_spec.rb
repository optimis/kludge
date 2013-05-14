require 'spec_helper'

describe Kludge::Many do
  class Leaf
    extend ActiveModel::Naming
  end

  let(:leaf1) { Leaf.new }
  let(:leaf2) { Leaf.new }
  let(:many)  { Kludge::Many.new(:leaves, :value => [leaf1, leaf2]) }

  describe '#valid?' do
    it 'returns true if all of its values are valid' do
      Leaf.any_instance.stub(:valid? => true)
      expect(many).to be_valid
    end

    it 'returns false if any of its values are not valid' do
      leaf1.stub(:valid? => true, :errors => [])
      leaf2.stub(:valid? => false, :errors => [])
      expect(many).to_not be_valid
    end

    it 'collects the uniq error messages of its values' do
      errors = ActiveModel::Errors.new(leaf1)
      errors.add(:name, 'cannot be blank')
      Leaf.any_instance.stub(:valid? => false, :errors => errors)
      many.valid?
      expect(many.errors.full_messages).to eql(['Name cannot be blank'])
    end
  end
end
