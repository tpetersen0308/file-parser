class OutputHandlerStub
  attr_accessor :output

  def initialize
    self.output = ""
  end

  def print(string)
    self.output = self.output + "\n" + string
  end
end
