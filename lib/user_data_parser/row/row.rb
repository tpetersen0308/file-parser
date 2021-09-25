require_relative "../utils/date.rb"

module UserDataParser
  class Row
    def initialize(data)
      set_columns(data)
    end

    def set_columns(data)
      data.each do |k,v|
        singleton_class.class_eval { attr_reader "#{k}" }
        set_attribute(k, v)
      end
    end

    def get_attributes
      attrs = {}
      self.instance_variables.each do |var|
        attrs[var.to_s.delete("@").to_sym] = self.instance_variable_get(var)
      end
      attrs
    end

    private
      def set_attribute(attr, value)
        attr_name = "@#{attr}".to_sym
        v = attr.to_s.include?("date") ? set_date(value) : value
        self.instance_variable_set(attr_name, v)
      end
  end
end
