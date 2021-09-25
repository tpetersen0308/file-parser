# User Data Parser

## Getting started

### Check your Ruby version

This project uses `ruby 2.7.1` and [rbenv](https://github.com/rbenv/rbenv) for ruby version management.

Check your ruby version with
```rbenv version```
and install with
```rbenv install 2.7.1```
if necessary.

### Install Dependencies

Using [Bundler](https://bundler.io/), install dependencies with
```bundle install```

### Running the tests

`bundle exec rspec`

### Running the app

From the project root, run the app with

```bin/bash/user_data_parser```

## Configuring the app

Parsing options can be configured via the config in `config/config.rb`.

Either replace the files in `/data` with your data files, or create a new
directory and update `:data_path` in the config with the location of your
files.

If necessary, add any new delimiters to `config[:delimiters]`.

Update `config[:gender_labels]` with any new gender labels that are included in your data.

### Input Types

`config[:input_types]` must be configured according to the structure of your data files.

Configure these with the delimiter types, filenames, and column orders that
correspond to your respective data files, as in the following example:

```
{
  delimiter: :pipe,
  filename: "pipe.txt",
  column_order: [
    :last_name,
    :first_name,
    :middle_initial,
    :gender,
    :favorite_color,
    :birth_date
  ]
}
```

Note: column names ending in `_date` must be in the format `M/D/YYYY` or `M-D-YYYY`.

### Output Types

`config[:output_rulesets]` can be configured to control the structure and
format of the parsed data when it is output to the console.

Configure these as in the following example. You must configure at least one set of output rules:

```
{
  title: "Output 1:",
  delimiter: :space,
  column_order: [
    :last_name,
    :first_name,
    :gender,
    :birth_date,
    :favorite_color
  ],
  sort_rows_by: [
    { key: :gender, direction: :asc },
    { key: :last_name, direction: :asc }
  ],
  gender_labels: {
    male: "Male",
    female: "Female"
  }
}
```

`:title` will be the heading of the output data.

`:delimiter` will be the delimiter type used in each row. It must correspond to
a delimiter specified in `config[:delimiters]`.

`:column_order` determines the ordering of the columns for the output data. It
must be a subset of column names that are included in all of your data files.

`:sort_rows_by` determines the primary, secondary, etc. keys and directions by
which your data will be sorted. You must configure at least one, and `:key`
must correspond to a column in `:column_order`.

`:gender_labels` determine the labels that will be used for a `:gender` column in your output data.
