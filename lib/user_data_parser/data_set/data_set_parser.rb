require_relative "./data_set.rb"

module UserDataParser
  class DataSetParser
    attr_reader :row_parser

    def initialize(row_parser)
      @row_parser = row_parser
    end

    def parse(data)
      data_set = DataSet.new
      parsed_rows = data.map do |row|
        row_parser.parse(row)
      end
      data_set = data_set.add_rows(parsed_rows)
      data_set
    end
  end
end
