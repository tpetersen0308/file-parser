require_relative "../../../spec/config/test_config.rb"
require_relative "../formatter.rb"
require_relative "../row/row_parser.rb"
require_relative "../data_set/data_set_parser.rb"

module UserDataParser
  class FileParser
    attr_reader :rules, :data_path

    def initialize(rules, data_path)
      @rules = rules
      @data_path = data_path
    end

    def parse(filename, data_set_parser)
      file = File.open(data_path + filename)
      data = file.readlines.map(&:chomp)
      file.close

      data_set_parser.parse(data).rows
    end
  end
end
