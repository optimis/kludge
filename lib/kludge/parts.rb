module Kludge
  class Parts
    include Enumerable

    def initialize
      @parts = []
    end

    def each
      @parts.each do |part|
        yield part
      end
    end

    def save
      graph.each do |root|
        root.save
      end
    end

    def valid?
      graph.map do |root|
        root.valid?
      end.all?
    end
    
    def names
      @parts.map(&:name)
    end

    def <<(part)
      @parts << part
    end

    def graph
      @graph ||= begin
        leaves.map { |leaf|
          assign_family(leaf)
        }.uniq
      end
    end

    def assign_family(node)
      parent = @parts.detect { |part| part.name == node.dependency }
      return node unless parent
      node.parent = parent
      parent.children << node
      assign_family(parent)
    end

    def leaves
      leaves = @parts.dup
      @parts.each do |part|
        leaves.delete_if { |leaf| leaf.name == part.dependency }
      end
      leaves
    end
  end
end

