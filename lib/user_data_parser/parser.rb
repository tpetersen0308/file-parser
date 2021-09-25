require_relative "./row/row.rb"
require_relative "./formatter.rb"
require_relative "./row/row_parser.rb"
require_relative "./data_set/data_set_parser.rb"
require_relative "./file/file_parser.rb"

module UserDataParser
  class Parser
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def parse(rules)
      formatter = build_formatter(rules)

      unsorted_parsed_data = config[:input_types].reduce([]) do |row_acc, input_type|
        row_parser, data_set_parser, file_parser = build_parsers(rules, input_type)
        filename = input_type[:filename]
        row_acc = row_acc + file_parser.parse(filename, data_set_parser)
        rows_with_formatted_attrs = row_acc.map{ |parsed_row| formatter.format_row_attributes(parsed_row) }
        rows_with_formatted_attrs.map{ |data| Row.new(data) }
      end

      sorted_data = chunk_sort(unsorted_parsed_data, rules[:sort_rows_by])
      sorted_data.map{ |row| formatter.format_row(row) }
    end

    def chunk_sort(rows, sorting_rules)
      if sorting_rules.empty?
        return rows.flatten
      end

      sort_key, sort_direction = [sorting_rules.first[:key], sorting_rules.first[:direction]]
      sorted_rows = sort_rows(rows, sort_key, sort_direction)
      chunked_rows = sorted_rows.chunk(&sort_key).to_a
      sorted_row_chunks = chunked_rows.map{ |_value, row_chunk| row_chunk }

      remaining_rules = sorting_rules[1..(sorting_rules.length - 1)]
      sorted_row_chunks.map do |n|
        chunk_sort(n, remaining_rules)
      end.flatten
    end

    private

      def build_formatter(rules)
        Formatter.new(rules, config[:delimiters], config[:gender_labels])
      end

      def build_parsers(rules, input_type)
        row_parser = RowParser.new(config[:delimiters], input_type)
        data_set_parser = DataSetParser.new(row_parser)
        file_parser = FileParser.new(rules, config[:data_path])
        [row_parser, data_set_parser, file_parser]
      end

      def sort_rows(rows, sort_key, direction)
        sorted = rows.sort do |a, b|
          if direction == :asc
            a.send(sort_key) <=> b.send(sort_key)
          else
            b.send(sort_key) <=> a.send(sort_key)
          end
        end
      end
  end
end
