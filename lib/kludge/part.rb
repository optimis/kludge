module Kludge
  class Part
    extend ActiveModel::Naming
    extend ActiveModel::Translation

    attr_reader :name, :errors, :value
    attr_accessor :parent, :children

    def initialize(name, options = {})
      @name = name
      @options = options
      @value = options[:value]
      @children = []
      @errors = ActiveModel::Errors.new(self)
    end

    def many?
      self.class == Many
    end

    def one?
      self.class == One
    end
    
    def dependent?
      @options[:belongs_to]
    end

    def dependency
      @options[:belongs_to]
    end

    def save
      children.each(&:save)
    end

    def valid?
      validate && children.map(&:valid?).all?
    end
  end
end
