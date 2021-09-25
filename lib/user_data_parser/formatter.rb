require_relative "./row/row.rb"

module UserDataParser
  class Formatter
    attr_reader :rules, :delimiters, :gender_labels

    def initialize(rules, delimiters, gender_labels)
      @rules = rules
      @delimiters = delimiters
      @gender_labels = gender_labels
    end

    def format_row(row)
      formatted_row_attributes = format_row_attributes(row)
      ordered_row = format_order(formatted_row_attributes)
      delimiter = delimiters[rules[:delimiter]]
      ordered_row.join(delimiter)
    end

    def format_row_attributes(row)
      row_data = row.get_attributes
      row_data[:birth_date] = format_date(row.birth_date)
      row_data[:gender] = format_gender(row.gender)
      row_data
    end

    private

      def format_date(date)
        date.strftime("%-m/%-d/%Y")
      end

      def format_gender(gender)
        gender_details = gender_labels.find do |_k, v|
          v.include?(gender)
        end
        gender_type = gender_details[0]

        rules[:gender_labels][gender_type]
      end

      def format_order(row_data)
        return rules[:column_order].map do |c|
          row_data[c]
        end
      end
  end
end
