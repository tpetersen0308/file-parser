require_relative "../config/config.rb"
require_relative "./user_data_parser/output_handler/output_handler.rb"
require_relative "./app.rb"

module UserDataParser
  output_handler = OutputHandler.new
  start(CONFIG, output_handler)
end
