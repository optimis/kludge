module Kludge
  class Mishmash
    
    def self.parts
      @parts ||= Parts.new
    end

    def self.one(name, options = {})
      parts << One.new(name, options)
      attr_reader name

      define_method "#{name}=" do |value|
        @parts.find { |part| part.name == name }.value = value
        instance_variable_set("@#{name}", value)
      end
    end

    def self.many(name, options = {})
      parts << Many.new(name, options)
      attr_reader name

      define_method "#{name}=" do |value|
        @parts.find { |part| part.name == name }.value = value
        instance_variable_set("@#{name}", value)
      end
    end

    def initialize(attributes = {})
      @parts = self.class.parts.dup
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

    def save
      @parts.save
    end

    def valid?
      @parts.valid?
    end
  end
end
