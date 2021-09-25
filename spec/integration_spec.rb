require_relative "../config/config.rb"
require_relative "../lib/app.rb"
require_relative "./stubs/output_handler_stub.rb"
require_relative "./stubs/output_stub.rb"

RSpec.describe "App" do
  it "parses and prints all data according to the config" do
    output_handler = OutputHandlerStub.new
    start(CONFIG, output_handler)
    expected = OUTPUT_STUB

    expect(output_handler.output).to eq(expected)
  end
end
