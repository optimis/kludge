module Kludge
  class Many < Part

    def save
      if parent
        parent.value.send("#{name}=", value)
      end

      value.each(&:save)
      super
    end

    def validate
      if value.any? { |v| !v.valid? }
        value.map(&:errors).each do |e|
          e.each do |attribute, errors_array|
            errors_array.each do |msg|
              errors.add(attribute, msg) unless errors.added?(attribute, msg)
            end
          end
        end
        false
      else
        true
      end
    end

    def value=(value)
      @value = if value.is_a?(Hash)
        value.map do |key, value|
          @name.to_s.classify.constantize.find(value.delete(:id)).tap { |v| v.assign_attributes(value) }
        end
      else
        value.map do |val|
          if val.is_a?(Hash)
            @name.to_s.classify.constantize.new(val)
          else
            val
          end
        end
      end
    end
  end
end
