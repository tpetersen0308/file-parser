require_relative "../config/test_config.rb"
require_relative "../../lib/user_data_parser/utils/date.rb"
require_relative "../../lib/user_data_parser/row/row_parser.rb"

RSpec.describe "RowParser" do
  before :all do
    @delimiters = TEST_CONFIG[:delimiters]
  end

  describe "#parse" do
    it "Parses pipe-delimited row of data according to the config" do
      input_type = TEST_CONFIG[:input_types][0]
      data = "Cooper | Dale | M | 4-19-1954"
      row_parser = UserDataParser::RowParser.new(@delimiters, input_type)
      expected_attributes = {
        first_name: "Dale",
        last_name: "Cooper",
        gender: "M",
        birth_date: set_date("4-19-1954")
      }

      actual = row_parser.parse(data)
      expect(actual).to have_attributes(expected_attributes)
    end

    it "Parses comma-delimited row of data according to the config" do
      input_type = TEST_CONFIG[:input_types][1]
      data = "Dale, Cooper, 4/19/1954, Male"
      row_parser = UserDataParser::RowParser.new(@delimiters, input_type)
      expected_attributes = {
        first_name: "Dale",
        last_name: "Cooper",
        gender: "Male",
        birth_date: set_date("4/19/1954")
      }

      actual = row_parser.parse(data)
      expect(actual).to have_attributes(expected_attributes)
    end

    it "Parses space-delimited row of data according to the config" do
      input_type = TEST_CONFIG[:input_types][2]
      data = "4/19/1954 Dale Cooper M"
      row_parser = UserDataParser::RowParser.new(@delimiters, input_type)
      expected_attributes = {
        first_name: "Dale",
        last_name: "Cooper",
        gender: "M",
        birth_date: set_date("4/19/1954")
      }

      actual = row_parser.parse(data)
      expect(actual).to have_attributes(expected_attributes)
    end
  end

  describe "#parse_delimiter_type" do
    before :all do
      @input_type = TEST_CONFIG[:input_types][0]
    end

    it "parses the delimiter type of a pipe-delimited row" do
      data = "Cooper | Dale | M | 4-19-1954"
      row_parser = UserDataParser::RowParser.new(@delimiters, @input_type)
      expected = :pipe

      actual = row_parser.parse_delimiter_type(data)
      expect(actual).to eq(expected)
    end

    it "parses the delimiter type of a comma-delimited row" do
      input_type = TEST_CONFIG[:input_types][0]
      delimiters = TEST_CONFIG[:delimiters]
      data = "Dale, Cooper, 4/19/1954, Male"
      row_parser = UserDataParser::RowParser.new(@delimiters, @input_type)
      expected = :comma

      actual = row_parser.parse_delimiter_type(data)
      expect(actual).to eq(expected)
    end

    it "parses the delimiter type of a space-delimited row" do
      input_type = TEST_CONFIG[:input_types][0]
      delimiters = TEST_CONFIG[:delimiters]
      data = "4/19/1954 Dale Cooper M"
      row_parser = UserDataParser::RowParser.new(@delimiters, @input_type)
      expected = :space

      actual = row_parser.parse_delimiter_type(data)
      expect(actual).to eq(expected)
    end
  end
end
