module Kludge
  class Many < Part

    def save
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
      p value
      @value = value.map do |val|
        if val.kind_of?(Hash)
          if val[:id].present?
            @name.to_s.classify.constantize.find(val.delete(:id)).tap { |v| v.assign_attributes(val) }
          else
            @name.to_s.classify.constantize.new(val)
          end
        else
          val
        end
      end
    end

  end
end
