require 'spec_helper'

describe Kludge::Mishmash do
  class Tree < Kludge::Mishmash
    one :trunk
    many :branches, :belongs_to => :trunk
  end

  let(:trunk) { mock :trunk }
  let(:branch) { mock :branch }
  let(:branches) { [branch, branch] }
  let(:tree) { Tree.new(:trunk => trunk, :branches => branches) }

  it 'contains many parts' do
    Tree.parts.names.should eql([:trunk, :branches])
  end

  it 'defines parts as "many" or "one"' do
    expect(Tree.parts.select(&:many?).length).to eql(1)
    expect(Tree.parts.select(&:one?).length).to eql(1)
  end

  it 'defines accessor methods for each part' do
    expect(tree.trunk).to eql(trunk)
    expect(tree.branches).to eql(branches)
  end

end
