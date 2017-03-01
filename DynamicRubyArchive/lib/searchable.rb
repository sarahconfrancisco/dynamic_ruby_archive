require_relative 'db_connection'
require_relative 'sql_object'
require 'byebug'
module Searchable
  def where(params)
    where_line, vals = where_line_and_values(params)
    search_results = DBConnection.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
    return [] if search_results.empty?
    parse_all(search_results)
  end

  def where_line_and_values(params)
    where_line = []
    vals = []
    params.each do |k, v|
      where_line << k.to_s + " = ?"
      vals << v
    end
    where_line = where_line.join(" AND ")
    [where_line, vals]
  end
end

class SQLObject
  extend Searchable
end
