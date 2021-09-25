TEST_CONFIG = {
  data_path: "spec/stubs/data/",
  delimiters: {
    pipe: "|",
    comma: ",",
    space: " "
  },
  gender_labels: {
    male: ["M", "Male"],
    female: ["F", "Female"]
  },
  input_types: [
    {
      delimiter: :pipe,
      filename: "pipe.txt",
      column_order: [:last_name, :first_name, :gender, :birth_date],
    },
    {
      delimiter: :comma,
      filename: "comma.txt",
      column_order: [:first_name, :last_name, :birth_date, :gender],
    },
    {
      delimiter: :space,
      filename: "space.txt",
      column_order: [:birth_date, :first_name, :last_name, :gender],
    }
  ],
  output_rulesets: [
    {
      delimiter: :space,
      column_order: [:birth_date, :gender, :last_name, :first_name],
      sort_rows_by: [
        { key: :gender, direction: :asc },
        { key: :last_name, direction: :desc }
      ],
      gender_labels: {
        male: "Male",
        female: "Female"
      }
    }
  ]
}
