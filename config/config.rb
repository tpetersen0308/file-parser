CONFIG = {
  data_path: "data/",
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
      column_order: [:last_name, :first_name, :middle_initial, :gender, :favorite_color, :birth_date]
    },
    {
      delimiter: :comma,
      filename: "comma.txt",
      column_order: [:last_name, :first_name, :gender, :favorite_color, :birth_date]
    },
    {
      delimiter: :space,
      filename: "space.txt",
      column_order: [:last_name, :first_name, :middle_initial, :gender, :birth_date, :favorite_color]
    }
  ],
  output_rulesets: [
    {
      title: "Output 1:",
      delimiter: :space,
      column_order: [:last_name, :first_name, :gender, :birth_date, :favorite_color],
      sort_rows_by: [
        { key: :gender, direction: :asc },
        { key: :last_name, direction: :asc }
      ],
      gender_labels: {
        male: "Male",
        female: "Female"
      }
    },
    {
      title: "Output 2:",
      delimiter: :space,
      column_order: [:last_name, :first_name, :gender, :birth_date, :favorite_color],
      sort_rows_by: [
        { key: :birth_date, direction: :asc },
        { key: :last_name, direction: :asc }
      ],
      gender_labels: {
        male: "Male",
        female: "Female"
      }
    },
    {
    title: "Output 3:",
      delimiter: :space,
      column_order: [:last_name, :first_name, :gender, :birth_date, :favorite_color],
      sort_rows_by: [
        { key: :last_name, direction: :desc }
      ],
      gender_labels: {
        male: "Male",
        female: "Female"
      }
    }
  ]
}
