module UserDataParser
  class DataSet
    attr_reader :rows

    def initialize(rows = [])
      @rows = rows
    end

    def add_rows(rows)
      DataSet.new(@rows + rows)
    end
  end
end
