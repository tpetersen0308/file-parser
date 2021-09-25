require "date"

def set_date(date_str)
  date_elements = date_str.gsub(/\/|-/, " ")
  Date.strptime(date_elements, "%m %d %Y")
end
