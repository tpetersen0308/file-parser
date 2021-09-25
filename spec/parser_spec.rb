require_relative "./config/test_config.rb"
require_relative "../lib/user_data_parser/utils/date.rb"
require_relative "../lib/user_data_parser/row/row.rb"
require_relative "../lib/user_data_parser/parser.rb"

RSpec.describe "Parser" do
  describe "#parse_user_data" do
    it "parses all of the files in the data directory provided by the config" do
      parser = UserDataParser::Parser.new(TEST_CONFIG)

      expected = [
        "4/10/2030 Female Thrace Kara",
        "10/8/2092 Female Ripley Ellen",
        "5/26/1951 Female Ride Sally",
        "7/5/1958 Male Watterson Bill",
        "4/19/1954 Male Cooper Dale"
      ]

      actual = parser.parse(TEST_CONFIG[:output_rulesets][0])

      expect(actual).to eq(expected)
    end
  end

  describe "#chunk_sort" do
    before :all do
      data = [
        {
          first_name: "Kara",
          last_name: "Thrace",
          birth_date: "4/10/2030",
          gender: "Female"
        },
        {
          first_name: "Dale",
          last_name: "Cooper",
          birth_date: "4/19/1954",
          gender: "Male"
        },
        {
          first_name: "Ellen",
          last_name: "Ripley",
          birth_date: "10/8/2092",
          gender: "Female"
        }
      ]
      @rows = data.map { |r| UserDataParser::Row.new(r) }
      @parser = UserDataParser::Parser.new(TEST_CONFIG)
    end

    it "sorts rows based on a single attribute in ascending order" do
      sort_rows_by = [{ key: :first_name, direction: :asc }]
      sorted_rows = @parser.chunk_sort(@rows, sort_rows_by)

      expect(sorted_rows[0].first_name).to eq("Dale")
      expect(sorted_rows[1].first_name).to eq("Ellen")
      expect(sorted_rows[2].first_name).to eq("Kara")
    end

    it "sorts rows based on a single attribute in descending order" do
      sort_rows_by = [{ key: :last_name, direction: :desc }]
      sorted_rows = @parser.chunk_sort(@rows, sort_rows_by)

      expect(sorted_rows[0].last_name).to eq("Thrace")
      expect(sorted_rows[1].last_name).to eq("Ripley")
      expect(sorted_rows[2].last_name).to eq("Cooper")
    end

    it "can sort by date" do
      sort_rows_by = [{ key: :birth_date, direction: :desc }]
      sorted_rows = @parser.chunk_sort(@rows, sort_rows_by)

      expect(sorted_rows[0].birth_date).to eq(set_date("10/8/2092"))
      expect(sorted_rows[1].birth_date).to eq(set_date("4/10/2030"))
      expect(sorted_rows[2].birth_date).to eq(set_date("4/19/1954"))
    end

    it "can sub-sort" do
      sort_rows_by = [{ key: :gender, direction: :desc }, { key: :last_name, direction: :asc }]
      sorted_rows = @parser.chunk_sort(@rows, sort_rows_by)

      expect(sorted_rows[0].last_name).to eq("Cooper")
      expect(sorted_rows[1].last_name).to eq("Ripley")
      expect(sorted_rows[2].last_name).to eq("Thrace")
    end
  end
end
