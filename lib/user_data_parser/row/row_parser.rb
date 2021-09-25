require_relative "./row.rb"

module UserDataParser
  class RowParser
    attr_reader :delimiters, :input_type

    def initialize(delimiters, input_type)
      @delimiters = delimiters
      @input_type = input_type
    end

    def parse(data)
      values = data.split(delimiters[input_type[:delimiter]])
      parsed_row_data = {}
      values.each_with_index do |v, i|
        parsed_row_data[input_type[:column_order][i]] = v.strip
      end
      return Row.new(parsed_row_data)
    end

    def parse_delimiter_type(data)
      if data.include?(delimiters[:pipe])
        return :pipe
      elsif data.include?(delimiters[:comma])
        return :comma
      end
      :space
    end
  end
end
