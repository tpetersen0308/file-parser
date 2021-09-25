require_relative "../../lib/user_data_parser/utils/date.rb"
require_relative "../../lib/user_data_parser/data_set/data_set_parser.rb"
require_relative "../../lib/user_data_parser/row/row_parser.rb"

RSpec.describe "DataSetParser" do
  describe "#parse_data_set" do
    it "parses out the rows of a set of data" do
      delimiters = TEST_CONFIG[:delimiters]
      input_type = TEST_CONFIG[:input_types][0]
      data_set = [
        "Cooper | Dale | Male | 4/19/1954",
        "Ripley | Ellen | Female | 10/8/2092",
        "Thrace | Kara | Female | 4/10/2030"
      ]
      expected = [
        {
          first_name: "Dale",
          last_name: "Cooper",
          birth_date: set_date("4/19/1954"),
          gender: "Male"
        },
        {
          first_name: "Ellen",
          last_name: "Ripley",
          birth_date: set_date("10/8/2092"),
          gender: "Female"
        },
        {
          first_name: "Kara",
          last_name: "Thrace",
          birth_date: set_date("4/10/2030"),
          gender: "Female"
        }
      ]

      row_parser = UserDataParser::RowParser.new(delimiters, input_type)
      data_set_parser = UserDataParser::DataSetParser.new(row_parser)
      actual = data_set_parser.parse(data_set).rows

      expect(actual[0]).to have_attributes(expected[0])
      expect(actual[1]).to have_attributes(expected[1])
      expect(actual[2]).to have_attributes(expected[2])
    end
  end
end
