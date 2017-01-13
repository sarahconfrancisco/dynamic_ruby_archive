require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    if @columns
      @columns
    else
      cols = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{table_name}
      SQL
      @columns = cols.first.map{|col| col.to_sym}
    end
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col.to_s) do
        attributes[col]
      end
      define_method(col.to_s + "=") do |value|
        attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name ||= self.to_s.tableize

  end

  def self.all
    # ...
    x = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
      #{table_name}
    SQL
    self.parse_all(x)
  end

  def self.parse_all(results)
    # ...
    objects = []
    results.each do |hash|
      objects << self.new(hash)
    end
    objects
  end

  def self.find(id)
    # ...
    x = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
      #{table_name}
      where
      id = ?
    SQL
    if x.empty?
      nil
    else
      self.new(x.first)
    end
  end

  def initialize(params = {})
    # ...
    # debugger
    params.each do |attr_name, value|
      if self.class.columns.include?(attr_name.to_sym)
        send(attr_name.to_s + "=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}

  end

  def attribute_values
    # ...
    values = []
    attributes.each do |k, v|
      values << v
    end
    values
  end

  def insert
    # ...
    vals = attribute_values
    # debugger

    col_names = self.class.columns
    n = col_names.size - 1
    qmarks = (["?"] * n).join(", ")
    x = DBConnection.execute(<<-SQL, *vals)
      INSERT INTO
        #{self.class.table_name} (#{col_names[1..-1].join(", ")})
      VALUES
        (#{qmarks})

    SQL
    attributes[:id] = DBConnection.last_insert_row_id
  end

  def update
    # ...
    vals = attribute_values
    col_names_and_qmarks = self.class.columns[1..-1].join(" = ?, ") + " = ?"
    # debugger
    DBConnection.execute(<<-SQL, *vals[1..-1])
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names_and_qmarks}
      WHERE
        id = #{self.id}

    SQL
  end

  def save
    # ...
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
