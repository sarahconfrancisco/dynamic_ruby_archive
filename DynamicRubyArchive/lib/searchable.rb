require_relative 'db_connection'
require_relative 'sql_object'
require 'byebug'
module Searchable
  def where(params)
    where_line = []
    vals = []
    params.each do |k, v|
      where_line << k.to_s + " = ?"
      vals << v
    end
    where_line = where_line.join(" AND ")
    x = DBConnection.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
    ret_array = []
    if x.empty?
      []
    else
      parse_all(x)
    end
  end
end

class SQLObject
  extend Searchable
end
