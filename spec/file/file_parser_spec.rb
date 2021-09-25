require_relative "../config/test_config.rb"
require_relative "../../lib/user_data_parser/utils/date.rb"
require_relative "../../lib/user_data_parser/file/file_parser.rb"
require_relative "../../lib/user_data_parser/formatter.rb"

RSpec.describe "FileParser" do
  describe "#parse_file" do
    it "parses a file according to an input type and ruleset" do
      delimiters = TEST_CONFIG[:delimiters]
      input_type = TEST_CONFIG[:input_types][0]
      rules = TEST_CONFIG[:output_rulesets][0]
      data_path = TEST_CONFIG[:data_path]

      row_parser = UserDataParser::RowParser.new(delimiters, input_type)
      data_set_parser = UserDataParser::DataSetParser.new(row_parser)
      file_parser = UserDataParser::FileParser.new(rules, data_path)

      expected = [
        {
          first_name: "Dale",
          last_name: "Cooper",
          birth_date: set_date("4/19/1954"),
          gender: "M"
        },
        {
          first_name: "Ellen",
          last_name: "Ripley",
          birth_date: set_date("10/8/2092"),
          gender: "F"
        },
        {
          first_name: "Kara",
          last_name: "Thrace",
          birth_date: set_date("4/10/2030"),
          gender: "F"
        }
      ]

      actual = file_parser.parse("pipe.txt", data_set_parser)

      expect(actual[0]).to have_attributes(expected[0])
      expect(actual[1]).to have_attributes(expected[1])
      expect(actual[2]).to have_attributes(expected[2])
    end
  end
end
