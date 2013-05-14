module Kludge
  class One < Part

    def save
      value.save
      super
    end

    def validate
      if !value.valid? 
        value.errors.each do |attribute, errors_array|
          errors_array.each do |msg|
            errors.add(attribute, msg) unless errors.added?(attribute, msg)
          end
        end
        false
      else
        true
      end
    end

    def value=(value)
      @value = if value.kind_of?(Hash)
        if value[:id]
          @name.to_s.classify.constantize.find(value.delete(:id)).tap { |v| v.assign_attributes(value) }
        else
          @name.to_s.classify.constantize.new(value)
        end
      else
        value
      end
    end
  end
end
