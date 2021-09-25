require_relative "./config/test_config.rb"
require_relative "../lib/user_data_parser/formatter.rb"
require_relative "../lib/user_data_parser/row/row.rb"

RSpec.describe "Formatter" do
  describe "#format_row" do
    it "formats the row data according to the output ruleset" do
      rules = TEST_CONFIG[:output_rulesets][0]
      gender_labels = TEST_CONFIG[:gender_labels]
      data = {
        first_name: "Dale",
        last_name: "Cooper",
        gender: "M",
        birth_date: "4-19-1954"
      }
      row = UserDataParser::Row.new(data)
      formatter = UserDataParser::Formatter.new(rules, TEST_CONFIG[:delimiters], gender_labels)
      expected = "4/19/1954 Male Cooper Dale"
      actual = formatter.format_row(row)

      expect(actual).to eq(expected)
    end
  end
end
