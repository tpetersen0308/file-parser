require_relative "./user_data_parser/parser.rb"

def start(config, output_handler)
  output_rulesets = config[:output_rulesets]
  parser = UserDataParser::Parser.new(config)
  output_rulesets.each do |rules|
    parsed_data = parser.parse(rules)
    output_handler.print(rules[:title])
    parsed_data.each{ |row| output_handler.print(row) }
    output_handler.print("")
  end
end
