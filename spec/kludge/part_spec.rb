require 'spec_helper'

describe Kludge::Part do
  describe '#name' do
    it 'returns the given name for the part' do
      expect(Kludge::Part.new('branch').name).to eql('branch')
    end
  end
end
